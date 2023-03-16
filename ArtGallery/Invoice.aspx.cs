using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using iTextSharp.text;
using System.IO;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System.Net;
using System.Net.Mail;
using System.Text;

namespace ArtGallery.Properties
{
    public partial class Invoice : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(Connection.GetConnectionString());
        SqlDataAdapter sda;
        DataTable dt;
        DataSet ds;
        string address = string.Empty;
        bool reprint = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["username"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                string orderId = Session["orderId"].ToString();
                lblOrderNo.Text = orderId;
                FindOrderDate(lblOrderNo.Text);
                if (Session["Address"] == null)
                {
                    FindOrderAddress(address);
                } else
                {
                    address = this.Session["Address"].ToString();
                }
                lblBuyerAddress.Text = address;
                ShowGrid(lblOrderNo.Text);
                
            }
            if (Session["orderId"] == null)
            {
                Response.Redirect("Cart.aspx");
            }

            // If previous page is redirected from payment page, then email will be auto sent.
            Uri MyUrl = Request.UrlReferrer;
            if (PreviousPage != null && Server.HtmlEncode(MyUrl.AbsolutePath) == "/Payment.aspx")
            {
                SendEmailReceipt();
                lblSentMessage.Text = "E - invoice also has been send to your email address. Cheers! 😉";
                btnEmail.Visible = false;         
            }
        }

        private void FindOrderAddress(string Addr)
        {
            sda = new SqlDataAdapter("SELECT * FROM Users WHERE Username=@Username", con);
            sda.SelectCommand.Parameters.AddWithValue("@Username", Session["username"]);
            ds = new DataSet();
            sda.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                address = ds.Tables[0].Rows[0]["PhysicalAddress"].ToString();
            }
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            // base.VerifyRenderingInServerForm(control);
        }

        private void ShowGrid(string text)
        {
            dt = new DataTable();
            DataRow dr;
            dt.Columns.Add("ArtworkId");
            dt.Columns.Add("Name");
            dt.Columns.Add("Price");
            dt.Columns.Add("Quantity");
            dt.Columns.Add("TotalPrice");
            sda = new SqlDataAdapter("SELECT a.ArtworkId, a.Name, a.ImageUrl, o.Quantity, a.Price FROM Orders o, Artworks a " +
                "WHERE o.ArtworkId = a.ArtworkId and OrderNo=@orderNo;", con);
            sda.SelectCommand.Parameters.AddWithValue("@orderNo", lblOrderNo.Text);
            ds = new DataSet();
            sda.Fill(ds);
            int totalRows = ds.Tables[0].Rows.Count;
            int i = 0;
            double grandTotal = 0.0;
            while (i < totalRows)
            {
                dr = dt.NewRow();
                dr["ArtworkId"] = ds.Tables[0].Rows[i]["ArtworkId"].ToString();
                dr["Name"] = ds.Tables[0].Rows[i]["Name"].ToString();
                dr["Price"] = ds.Tables[0].Rows[i]["Price"].ToString();
                dr["Quantity"] = ds.Tables[0].Rows[i]["Quantity"].ToString();

                double dblPrice = Convert.ToDouble(ds.Tables[0].Rows[i]["Price"].ToString());
                int intQuantity = Convert.ToInt16(ds.Tables[0].Rows[i]["Quantity"].ToString());
                double dblTotalPrice = dblPrice * intQuantity;
                dr["TotalPrice"] = dblTotalPrice;
                grandTotal += dblTotalPrice;
                dt.Rows.Add(dr);
                i++;
            }
            grvOrder.DataSource = dt;
            grvOrder.DataBind();
            lblGrand.Text = grandTotal.ToString("C");
            lblCount.Text = totalRows.ToString();
        }

        private void FindOrderDate(string orderId)
        {
            con.Open();
            sda = new SqlDataAdapter("SELECT * FROM Orders WHERE OrderNo= @orderNo", con);
            sda.SelectCommand.Parameters.AddWithValue("@orderNo", lblOrderNo.Text);
            ds = new DataSet();
            sda.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                lblOrderDate.Text = ds.Tables[0].Rows[0]["OrderDate"].ToString();
            }
            con.Close();
        }

        protected void btnDownload_Click(object sender, EventArgs e)
        {
            ExportPdf();
        }

        private void ExportPdf()
        {
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment; filename=Invoice_LeLouvre.pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            Panel1.RenderControl(hw);
            StringReader sr = new StringReader(sw.ToString());
            Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 100f, 0f);
            HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
            PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
            pdfDoc.Open();
            htmlparser.Parse(sr);
            pdfDoc.Close();
            Response.Write(pdfDoc);
            Response.End();
        }

        private void SendEmailReceipt()
        {
            //Email details (subject , sender, receiver
            string to = Session["userEmail"].ToString();
            string from = "dummyliciousx@gmail.com";
            MailMessage mail = new MailMessage(from, to);


            //email content formatted with html
            StringBuilder content = new StringBuilder();
            content.Append("<h1>LE LOUVRE</h1>");
            content.Append(Session["username"].ToString() + ",");
            if (reprint == true)
            {
                content.Append("<p>You have requested us to send you an invoice on </P>" + DateTime.Now.ToString());
            }
            else
            {
                content.Append("<p>Thank you for your purchase, your order has been processed.");
            }
            content.Append("<p>Attached below are the Invoice to your order.");
            mail.Subject = "Le Louvre Order Invoice!";
            mail.Body = content.ToString();
            mail.BodyEncoding = Encoding.UTF8;
            mail.IsBodyHtml = true;

            //email connection and configuration
            SmtpClient client = new SmtpClient("smtp.gmail.com", 587);
            NetworkCredential basicCredential1 = new
            NetworkCredential("dummyliciousx@gmail.com", "Dummy123!!");
            client.EnableSsl = true;
            client.UseDefaultCredentials = false;
            client.Credentials = basicCredential1;

            //pdf generation and email attachment 
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            Panel1.RenderControl(hw);
            StringReader sr = new StringReader(sw.ToString());
            Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 100f, 0f);
            HTMLWorker htmlparser = new HTMLWorker(pdfDoc);

            using (MemoryStream memoryStream = new MemoryStream())
            {
                PdfWriter writer = PdfWriter.GetInstance(pdfDoc, memoryStream);
                pdfDoc.Open();
                htmlparser.Parse(sr);
                pdfDoc.Close();
                byte[] bytes = memoryStream.ToArray();
                memoryStream.Close();
                mail.Attachments.Add(new Attachment(new MemoryStream(bytes), "Invoice_LeLouvre.pdf"));
            }

            try
            {
                client.Send(mail);
            }
            catch (Exception ex)
            {
                string error = "Error-" + ex.Message;
            }
        }

        protected void btnEmail_Click(object sender, EventArgs e)
        {
            reprint = true;
            
            SendEmailReceipt();
            lblSentMessage.Text = "The Invoice Has been sent to your email address";
            lblSentMessage.Style.Add("color", "red");

            btnEmail.Enabled = false;
        }

    }
}