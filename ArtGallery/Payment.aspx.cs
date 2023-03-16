using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace ArtGallery
{
    public partial class Payment : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(Connection.GetConnectionString());
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        bool isTrue = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["username"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
            }
            lblMsg.Visible = false;
            lblTotal1.Text = Convert.ToDouble(Session["TotalPrice"]).ToString("C");
            lblTotal2.Text = Convert.ToDouble(Session["TotalPrice"]).ToString("C");

            chkAddress1.Attributes.Add("onclick", "EnableDisableCheckBox()");
            chkAddress2.Attributes.Add("onclick", "EnableDisableCheckBox()");
        }

        protected void btnConfirmPayment_Click(object sender, EventArgs e)
        {
            if (!chkAddress1.Checked)
                Page.Validate("addressCC");

            if (Session["buyArtwork"] != null && Session["orderId"] != null)
            {
                dt = (DataTable)Session["buyArtwork"];
                for (int i = 0; i <= dt.Rows.Count - 1; i++)
                {
                    string artworkId = dt.Rows[i]["ArtworkId"].ToString();
                    int aQuantity = Convert.ToInt16(dt.Rows[i]["Quantity"]);
                    sda = new SqlDataAdapter("SELECT Quantity FROM Artworks WHERE ArtworkId=@id", con);
                    sda.SelectCommand.Parameters.AddWithValue("@id", artworkId);
                    DataTable dtble = new DataTable();
                    sda.Fill(dtble);
                    int quantity = Convert.ToInt16(dtble.Rows[0][0]);
                    if (quantity > 0)
                    {
                        con.Open();
                        cmd = new SqlCommand("INSERT INTO Orders(OrderNo, ArtworkId, Quantity, Username, Status, OrderDate) VALUES(@OrderNo, @ArtworkId, @Quantity, @Username, @Status, @OrderDate)", con);
                        cmd.Parameters.AddWithValue("@OrderNo", Session["orderId"]);
                        cmd.Parameters.AddWithValue("@ArtworkId", dt.Rows[i]["ArtworkId"]);
                        cmd.Parameters.AddWithValue("@Quantity", dt.Rows[i]["Quantity"]);
                        cmd.Parameters.AddWithValue("@Username", Session["username"]);
                        cmd.Parameters.AddWithValue("@Status", "Pending");
                        cmd.Parameters.AddWithValue("@OrderDate", Convert.ToDateTime(DateTime.Now.ToString()));
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                }
                DecreaseQuantity();
                MakePayment();
                ClearCart();
                Session["buyArtwork"] = null;

                //Use server transfer so invoice page can detect the previouspage function
                Server.Transfer("Invoice.aspx");
            }
            else
            {
                Response.Redirect("Cart.aspx");
            }
        }

        private void ClearCart()
        {
            if (Session["username"] != null)
            {
                dt = (DataTable)Session["buyArtwork"];
                for (int i = 0; i <= dt.Rows.Count - 1; i++)
                {
                    int artworkId = Convert.ToInt16(dt.Rows[i]["ArtworkId"]);
                    con.Open();
                    SqlCommand cmd = new SqlCommand("DELETE FROM Carts WHERE ArtworkId=@id AND Username=@username", con);
                    cmd.Parameters.AddWithValue("@id", artworkId);
                    cmd.Parameters.AddWithValue("@username", Session["username"]);
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        private void MakePayment()
        {
            if (isTrue == true)
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("INSERT INTO Payment(Name, CardNo, ExpiryDate, CvvNo, Address, PaymentMode) VALUES (@Name, @CardNo, @ExpiryDate, @CvvNo, @Address, @PaymentMode)", con);
                cmd.Parameters.AddWithValue("@Name", txtCardHolder.Text);
                cmd.Parameters.AddWithValue("@CardNo", txtCardNumber.Text);
                cmd.Parameters.AddWithValue("@ExpiryDate", ddlMonth.SelectedValue + '/' + ddlYear.SelectedValue);
                cmd.Parameters.AddWithValue("@CvvNo", txtCvv.Text);
                cmd.Parameters.AddWithValue("@PaymentMode", "Credit Card");

                if (chkAddress1.Checked == true)
                {
                    RequiredFieldValidator5.Enabled = false;
                    SqlCommand cmdgetUserAdd = new SqlCommand("SELECT PhysicalAddress from Users where Username=@username", con);
                    cmdgetUserAdd.Parameters.AddWithValue("@username", Session["username"].ToString());
                    object getUserAdd = cmdgetUserAdd.ExecuteScalar();
                    if (getUserAdd != null)
                    {
                        
                        cmd.Parameters.AddWithValue("@Address", getUserAdd.ToString());
                        Session["Address"] = getUserAdd.ToString();
                    }
                    else
                    {
                        lblMsg.Visible = true;
                        lblMsg.Text = "Error occured, Invalid Address";
                        lblMsg.CssClass = "alert alert-danger";
                        return;
                    }
                }
                else
                {
                    RequiredFieldValidator5.Enabled = true;
                    cmd.Parameters.AddWithValue("@Address", txtAddress1.Text);
                    Session["Address"] = txtAddress1.Text;
                }
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        private void DecreaseQuantity()
        {
            dt = (DataTable)Session["buyArtwork"];
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                int artworkId = Convert.ToInt16(dt.Rows[i]["ArtworkId"]);
                int aQuantity = Convert.ToInt16(dt.Rows[i]["Quantity"]);
                SqlDataAdapter sda = new SqlDataAdapter("SELECT Quantity FROM Artworks WHERE ArtworkId=@id", con);
                sda.SelectCommand.Parameters.AddWithValue("@id", artworkId);
                DataTable dtble = new DataTable();
                sda.Fill(dtble);
                int quantity = Convert.ToInt16(dtble.Rows[0][0]);
                if (quantity > 0)
                {
                    int reducedQuantity = quantity - aQuantity;
                    con.Open();
                    cmd = new SqlCommand("Artwork_Crud", con);
                    cmd.Parameters.AddWithValue("@Action", "QTYUPDATE");
                    cmd.Parameters.AddWithValue("@Quantity", reducedQuantity);
                    cmd.Parameters.AddWithValue("@ArtworkId", artworkId);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();
                    con.Close();
                    isTrue = true;
                }
                else
                {
                    isTrue = false;
                }
            }
        }

        protected void btnConfirmOrder_Click(object sender, EventArgs e)
        {
            if (!chkAddress2.Checked)
                Page.Validate("addressCOD");

            if (Session["buyArtwork"] != null && Session["orderId"] != null)
            {
                dt = (DataTable)Session["buyArtwork"];
                for (int i = 0; i <= dt.Rows.Count - 1; i++)
                {
                    string artworkId = dt.Rows[i]["ArtworkId"].ToString();
                    int aQuantity = Convert.ToInt16(dt.Rows[i]["Quantity"]);
                    sda = new SqlDataAdapter("SELECT Quantity FROM Artworks WHERE ArtworkId=@id", con);
                    sda.SelectCommand.Parameters.AddWithValue("@id", artworkId);
                    DataTable dtble = new DataTable();
                    sda.Fill(dtble);
                    int quantity = Convert.ToInt16(dtble.Rows[0][0]);
                    if (quantity > 0)
                    {
                        con.Open();
                        cmd = new SqlCommand("INSERT INTO Orders(OrderNo, ArtworkId, Quantity, Username, Status, OrderDate) VALUES(@OrderNo, @ArtworkId, @Quantity, @Username, @Status, @OrderDate)", con);
                        cmd.Parameters.AddWithValue("@OrderNo", Session["orderId"]);
                        cmd.Parameters.AddWithValue("@ArtworkId", dt.Rows[i]["ArtworkId"]);
                        cmd.Parameters.AddWithValue("@Quantity", dt.Rows[i]["Quantity"]);
                        cmd.Parameters.AddWithValue("@Username", Session["username"]);
                        cmd.Parameters.AddWithValue("@Status", "Pending");
                        cmd.Parameters.AddWithValue("@OrderDate", Convert.ToDateTime(DateTime.Now.ToString()));
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                }
                DecreaseQuantity();
                MakePayment2();
                ClearCart();
                Session["buyArtwork"] = null;

                //Use server transfer so invoice page can detect the previouspage function
                Server.Transfer("Invoice.aspx");
                //Response.Redirect("Invoice.aspx");
            }
            else
            {
                Response.Redirect("Cart.aspx");
            }
        }

        private void MakePayment2()
        {
            if (isTrue == true)
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("INSERT INTO Payment(Name, Address,PaymentMode) VALUES (@Name, @Address,@PaymentMode)", con);
                cmd.Parameters.AddWithValue("@Name", Session["username"]);
                cmd.Parameters.AddWithValue("@PaymentMode", "COD");

                if (chkAddress2.Checked == true)
                {
                    SqlCommand cmdgetUserAdd = new SqlCommand("SELECT PhysicalAddress from Users where Username=@username", con);
                    cmdgetUserAdd.Parameters.AddWithValue("@username", Session["username"].ToString());
                    object getUserAdd = cmdgetUserAdd.ExecuteScalar();
                    if (getUserAdd != null)
                    {
                        cmd.Parameters.AddWithValue("@Address", getUserAdd.ToString());
                        Session["Address"] = getUserAdd.ToString();

                    }
                    else
                    {
                        lblMsg.Visible = true;
                        lblMsg.Text = "Error occured, Invalid Address";
                        lblMsg.CssClass = "alert alert-danger";
                        return;
                    }
                }
                else
                {
                    cmd.Parameters.AddWithValue("@Address", txtAddress2.Text);
                    Session["Address"] = txtAddress2.Text;
                }
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
    }
}