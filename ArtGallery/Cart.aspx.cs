using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace ArtGallery
{
    public partial class Cart : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(Connection.GetConnectionString());
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        DataSet ds;
        static Boolean availableId = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["username"] == null)
                {
                    Response.Redirect("Login.aspx");
                }

                // Adding artwork to gridview
                Session["addArtwork"] = "false";
                dt = new DataTable();
                DataRow dr;
                dt.Columns.Add("No");
                dt.Columns.Add("ArtworkId");
                dt.Columns.Add("Name");
                dt.Columns.Add("ImageUrl");
                dt.Columns.Add("Price");
                dt.Columns.Add("Quantity");
                dt.Columns.Add("TotalPrice");

                if (Request.QueryString["id"] != null)
                {
                    if (Session["buyArtwork"] == null)
                    {
                        dr = dt.NewRow();
                        sda = new SqlDataAdapter("SELECT * FROM Artworks WHERE ArtworkId=@id", con);
                        sda.SelectCommand.Parameters.AddWithValue("@id", Request.QueryString["id"]);
                        DataSet ds = new DataSet();
                        sda.Fill(ds);

                        dr["No"] = 1;
                        dr["ArtworkId"] = ds.Tables[0].Rows[0]["ArtworkId"].ToString();
                        dr["Name"] = ds.Tables[0].Rows[0]["Name"].ToString();
                        dr["ImageUrl"] = ds.Tables[0].Rows[0]["ImageUrl"].ToString();
                        dr["Price"] = ds.Tables[0].Rows[0]["Price"].ToString();
                        dr["Quantity"] = Request.QueryString["quantity"];

                        double dblPrice = Convert.ToDouble(ds.Tables[0].Rows[0]["Price"].ToString());
                        int intQuantity = Convert.ToInt16(Request.QueryString["quantity"]);
                        double dblTotalPrice = dblPrice * intQuantity;
                        dr["TotalPrice"] = dblTotalPrice;

                        dt.Rows.Add(dr);

                        con.Open();
                        cmd = new SqlCommand("INSERT INTO Carts VALUES(@ArtworkId, @Quantity, @Username)", con);
                        cmd.Parameters.AddWithValue("@ArtworkId", dr["ArtworkId"]);
                        cmd.Parameters.AddWithValue("@Quantity", dr["Quantity"]);
                        cmd.Parameters.AddWithValue("@Username", Session["username"]);
                        cmd.ExecuteNonQuery();
                        con.Close();

                        grvCart.DataSource = dt;
                        grvCart.DataBind();
                        Session["buyArtwork"] = dt;
                        btnCheckout.Enabled = true;

                        grvCart.FooterRow.Cells[5].Text = "Grand Total (RM)";
                        grvCart.FooterRow.Cells[6].Text = grandTotal().ToString();
                        Response.Redirect("Cart.aspx");
                    }
                    else
                    {
                        checkArtworkId();
                        if (availableId == true)
                        {
                            updateQuantity();
                            DataTable dt1 = (DataTable)Session["buyArtwork"];
                            grvCart.DataSource = dt1;
                            grvCart.DataBind();
                            Session["buyArtwork"] = dt1;
                            btnCheckout.Enabled = true;
                            availableId = false;
                            grvCart.FooterRow.Cells[5].Text = "Grand Total (RM)";
                            grvCart.FooterRow.Cells[6].Text = grandTotal().ToString();
                            Response.Redirect("Cart.aspx");
                        }
                        else
                        {
                            dt = (DataTable)Session["buyArtwork"];
                            int intNo;
                            intNo = dt.Rows.Count;

                            dr = dt.NewRow();
                            sda = new SqlDataAdapter("SELECT * FROM Artworks WHERE ArtworkId=@id", con);
                            sda.SelectCommand.Parameters.AddWithValue("@id", Request.QueryString["id"]);
                            ds = new DataSet();
                            sda.Fill(ds);

                            dr["No"] = intNo + 1;
                            dr["ArtworkId"] = ds.Tables[0].Rows[0]["ArtworkId"].ToString();
                            dr["Name"] = ds.Tables[0].Rows[0]["Name"].ToString();
                            dr["ImageUrl"] = ds.Tables[0].Rows[0]["ImageUrl"].ToString();
                            dr["Price"] = ds.Tables[0].Rows[0]["Price"].ToString();
                            dr["Quantity"] = Request.QueryString["quantity"];

                            double dblPrice = Convert.ToDouble(ds.Tables[0].Rows[0]["Price"].ToString());
                            int intQuantity = Convert.ToInt16(Request.QueryString["quantity"]);
                            double dblTotalPrice = dblPrice * intQuantity;
                            dr["TotalPrice"] = dblTotalPrice;

                            dt.Rows.Add(dr);

                            con.Open();
                            cmd = new SqlCommand("INSERT INTO Carts VALUES(@ArtworkId, @Quantity, @Username)", con);
                            cmd.Parameters.AddWithValue("@ArtworkId", dr["ArtworkId"]);
                            cmd.Parameters.AddWithValue("@Quantity", dr["Quantity"]);
                            cmd.Parameters.AddWithValue("@Username", Session["username"]);
                            cmd.ExecuteNonQuery();
                            con.Close();

                            grvCart.DataSource = dt;
                            grvCart.DataBind();
                            Session["buyArtwork"] = dt;
                            btnCheckout.Enabled = true;

                            grvCart.FooterRow.Cells[5].Text = "Grand Total (RM)";
                            grvCart.FooterRow.Cells[6].Text = grandTotal().ToString();
                            Response.Redirect("Cart.aspx");
                        }
                    }
                }
                else
                {
                    dt = (DataTable)Session["buyArtwork"];
                    grvCart.DataSource = dt;
                    grvCart.DataBind();
                    if (grvCart.Rows.Count > 0)
                    {
                        grvCart.FooterRow.Cells[5].Text = "Grand Total (RM)";
                        grvCart.FooterRow.Cells[6].Text = grandTotal().ToString();
                    }
                }
            }
            if (grvCart.Rows.Count.ToString() == "0")
            {
                btnClearCart.Enabled = false;
                btnClearCart.Style.Add("opacity", "0.4");
                btnCheckout.Enabled = false;
                btnCheckout.Style.Add("opacity", "0.4");
            }
            else
            {
                btnClearCart.Enabled = true;
                btnCheckout.Enabled = true;
            }
            generateOrderId();
        }

        private double grandTotal()
        {
            dt = new DataTable();
            dt = (DataTable)Session["buyArtwork"];
            int intRow = dt.Rows.Count;
            int i = 0;
            double totalPrice = 0.0;
            while (i < intRow)
            {
                totalPrice += Convert.ToDouble(dt.Rows[i]["TotalPrice"].ToString());
                i++;
            }
            Session["TotalPrice"] = totalPrice;
            return totalPrice;
        }

        private void generateOrderId()
        {
            String alpha = "abCdefghIjklmNopqrStuvwXyz123456789";
            Random ran = new Random();
            char[] myArray = new char[5];
            for (int i = 0; i < 5; i++)
            {
                myArray[i] = alpha[(int)(35 * ran.NextDouble())];
            }
            string orderId = DateTime.Now.Hour.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Second.ToString() + '-' +
                DateTime.Now.Day.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Year.ToString() + '-' + new string(myArray);
            Session["orderId"] = orderId;
        }

        private void updateQuantity()
        {
            int artworkId;
            int queryArtworkId = Convert.ToInt16(Request.QueryString["id"]);
            dt = (DataTable)Session["buyArtwork"];
            foreach (DataRow row in dt.Rows)
            {
                artworkId = Convert.ToInt16(row["ArtworkId"].ToString());
                if (artworkId == queryArtworkId)
                {
                    int newQuantity = Convert.ToInt16(row["Quantity"].ToString()) + Convert.ToInt16(Request.QueryString["quantity"].ToString());
                    row["Quantity"] = newQuantity;
                    double price = Convert.ToDouble(row["Price"].ToString());
                    double dblTotalPrice = price * newQuantity;
                    row["TotalPrice"] = dblTotalPrice;

                    con.Open();

                    cmd = new SqlCommand("UPDATE Carts SET Quantity = @Quantity WHERE ArtworkId = @ArtworkId AND Username = @Username", con);
                    cmd.Parameters.AddWithValue("@ArtworkId", row["ArtworkId"]);
                    cmd.Parameters.AddWithValue("@Quantity", row["Quantity"]);
                    cmd.Parameters.AddWithValue("@Username", Session["username"].ToString());
                    cmd.ExecuteNonQuery();
                    con.Close();

                    break;
                }
            }
            Session["buyArtwork"] = dt;
        }

        private void checkArtworkId()
        {
            int artworkId;
            int queryArtworkId = Convert.ToInt16(Request.QueryString["id"]);
            dt = (DataTable)Session["buyArtwork"];
            foreach (DataRow row in dt.Rows)
            {
                artworkId = Convert.ToInt16(row["ArtworkId"].ToString());
                if (artworkId == queryArtworkId)
                {
                    availableId = true;
                }
            }
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            bool isTrue = false;
            dt = (DataTable)Session["buyArtwork"];
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                int artworkId = Convert.ToInt16(dt.Rows[i]["ArtworkId"]);
                sda = new SqlDataAdapter("SELECT Quantity, Price FROM Artworks WHERE ArtworkId=@id", con);
                sda.SelectCommand.Parameters.AddWithValue("@id", artworkId);
                DataTable dtble = new DataTable();
                sda.Fill(dtble);
                int quantity = Convert.ToInt16(dtble.Rows[0][0]);
                if (quantity == 0)
                {
                    string artName = dtble.Rows[0][1].ToString();
                    string msg = "" + artName + " is out of stock";
                    Response.Write("<script>alert('" + msg + "');</script>");
                    isTrue = false;
                }
                else
                {
                    isTrue = true;
                }
            }
            if (grvCart.Rows.Count.ToString() == "0")
            {
                Response.Write("<script>alert('Your cart is empty. You cannot place order');</script>");
            }
            else
            {
                if (isTrue == true)
                {
                    Response.Redirect("Payment.aspx");
                }
            }
        }

        protected void btnClearCart_Click(object sender, EventArgs e)
        {
            Session["buyArtwork"] = null;
            ClearCart();
        }

        private void ClearCart()
        {
            con.Open();
            cmd = new SqlCommand("DELETE FROM Carts WHERE Username=@username", con);
            cmd.Parameters.AddWithValue("@username", Session["username"]);
            cmd.ExecuteNonQuery();
            con.Close();
            Response.Redirect("Cart.aspx");
        }

        protected void grvCart_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            dt = new DataTable();
            dt = (DataTable)Session["buyArtwork"];

            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                int intNo;
                int intNo2;
                int artworkId = Convert.ToInt16(dt.Rows[i]["ArtworkId"]);
                string qdata;
                string dtdata;
                intNo = Convert.ToInt32(dt.Rows[i]["No"].ToString());
                TableCell cell = grvCart.Rows[e.RowIndex].Cells[0];
                qdata = cell.Text;
                dtdata = intNo.ToString();
                intNo2 = Convert.ToInt32(qdata);
                TableCell artId = grvCart.Rows[e.RowIndex].Cells[1];

                if (intNo == intNo2)
                {
                    dt.Rows[i].Delete();
                    dt.AcceptChanges();

                    con.Open();
                    cmd = new SqlCommand("DELETE FROM Carts WHERE ArtworkId=@artworkId AND Username=@username", con);
                    cmd.Parameters.AddWithValue("@artworkId", artworkId);
                    cmd.Parameters.AddWithValue("@username", Session["username"]);
                    cmd.ExecuteNonQuery();
                    con.Close();

                    break;
                }
            }

            for (int i = 1; i <= dt.Rows.Count; i++)
            {
                dt.Rows[i - 1]["No"] = i;
                dt.AcceptChanges();
            }
            Session["buyArtwork"] = dt;
            Response.Redirect("Cart.aspx");
        }
    }
}