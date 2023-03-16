using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;
using System.Drawing;
using System.Data;

namespace ArtGallery
{
    public partial class UserInfo : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(Connection.GetConnectionString());
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }

            if (!IsPostBack)
            {
                retrieveUserDetail();
                GetOrderDetail();
            }

            string userType = Session["usertype"].ToString();
            if (userType == "Artist")
            {
                Response.Redirect("~/Artist/ArtistInfo.aspx");
            }
        }

        private void retrieveUserDetail()
        {
            con.Open();
            SqlCommand retrievecmd = new SqlCommand("SELECT Username, EmailAddress, Name, Password, Mobile, DOB, PhysicalAddress, ZipCode, ImageUrl, CreatedDate, Gender FROM Users WHERE Username=@username", con);
            retrievecmd.Parameters.AddWithValue("@username", Session["username"].ToString());
            using (SqlDataReader dr = retrievecmd.ExecuteReader())
            {
                dr.Read();
                lblUsername.Text = dr["Username"].ToString();
                lblEmail.Text = dr["EmailAddress"].ToString();
                string strNewFormat = dr["CreatedDate"].ToString();
                lblCreatedDate.Text = "Member since " + strNewFormat.Substring(0, 9);
                imgProfile.ImageUrl = dr["ImageUrl"].ToString();
                txtTableFullName.Text = dr["Name"].ToString();
                txtTablePW.Text = dr["Password"].ToString();
                txtTablePhoneNumber.Text = dr["Mobile"].ToString();
                txtTableEmailAddress.Text = dr["EmailAddress"].ToString();
                txtTableAddress.Text = dr["PhysicalAddress"].ToString();
                txtTableZipCode.Text = dr["ZipCode"].ToString();
                //Parse datetime 
                string conv = dr["DOB"].ToString();
                conv = DateTime.Parse(conv).ToString("yyyy-MM-dd");
                txtTableDOB.Text = conv.ToString();

                string gender = dr["Gender"].ToString();
                if (gender == "Male")
                {
                    radUserInfoGender.SelectedValue = "Male";
                }
                else
                    radUserInfoGender.SelectedValue = "Female";
            }
            disableTableTextBoxes();
            con.Close();
        }

        private void updateUserDetail()
        {
            con.Open();
            string imagePath = string.Empty, fileExtension = string.Empty;
            SqlCommand sqlCmd = new SqlCommand("UPDATE Users SET Name=@name, Password=@password, Mobile=@mobile, DOB=@DOBs, EmailAddress=@emailAddress, Gender=@gender, PhysicalAddress=@physicalAddress, ZipCode=@zipCode, ImageUrl=@imageUrl WHERE Username=@username", con);

            sqlCmd.Parameters.AddWithValue("@username", Session["username"].ToString());
            sqlCmd.Parameters.AddWithValue("@name", txtTableFullName.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@password", txtTablePW.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@mobile", txtTablePhoneNumber.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@DOBs", txtTableDOB.Text);
            sqlCmd.Parameters.AddWithValue("@emailAddress", txtTableEmailAddress.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@gender", radUserInfoGender.SelectedItem.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@physicalAddress", txtTableAddress.Text);
            sqlCmd.Parameters.AddWithValue("@zipCode", txtTableZipCode.Text.Trim());

            if (fuProfileImage.HasFile)
            {
                if (Utils.isValidExtension(fuProfileImage.FileName))
                {
                    Guid obj = Guid.NewGuid();
                    fileExtension = Path.GetExtension(fuProfileImage.FileName);
                    imagePath = "~/Images/Profile/" + obj.ToString() + fileExtension;
                    fuProfileImage.PostedFile.SaveAs(Server.MapPath("~/Images/Profile/") + obj.ToString() + fileExtension);
                    sqlCmd.Parameters.AddWithValue("@ImageUrl", imagePath);
                }
                else
                {
                    lblErrorMessage.Visible = true;
                    lblErrorMessage.Text = "Please select .jpg, .jpeg, .png image.";
                    return;
                }
            }
            else
            {
                sqlCmd.Parameters.AddWithValue("@imageUrl", imgProfile.ImageUrl.ToString());
            }

            int n = sqlCmd.ExecuteNonQuery();
            if (n > 0)
            {
                Response.Write("Profile Updated Successfully!");
            }
            else
            {
                Response.Write("Ops! Unable to update record.");
            }
            con.Close();
        }

        private void disableTableTextBoxes()
        {
            txtTableFullName.Enabled = false;
            txtTablePW.Attributes["type"] = "password";
            txtTablePW.Enabled = false;
            txtTablePhoneNumber.Enabled = false;
            txtTableEmailAddress.Enabled = false;
            txtTableAddress.Enabled = false;
            txtTableZipCode.Enabled = false;
            txtTableDOB.Enabled = false;
            fuProfileImage.Visible = false;
            fuProfileImage.Enabled = false;
            radUserInfoGender.Enabled = false;

            txtTableFullName.BorderStyle = BorderStyle.None;
            txtTablePW.BorderStyle = BorderStyle.None;
            txtTablePhoneNumber.BorderStyle = BorderStyle.None;
            txtTableEmailAddress.BorderStyle = BorderStyle.None;
            txtTableAddress.BorderStyle = BorderStyle.None;
            txtTableZipCode.BorderStyle = BorderStyle.None;
            txtTableDOB.BorderStyle = BorderStyle.None;
        }

        private void enableTableTextBoxes()
        {
            txtTableFullName.Enabled = true;
            txtTablePW.Enabled = true;
            txtTablePhoneNumber.Enabled = true;
            txtTableEmailAddress.Enabled = true;
            txtTableAddress.Enabled = true;
            txtTableZipCode.Enabled = true;
            txtTableDOB.Enabled = true;
            fuProfileImage.Visible = true;
            fuProfileImage.Enabled = true;
            radUserInfoGender.Enabled = true;
            txtTablePW.Attributes["type"] = "SingleLine";

            txtTableFullName.BorderStyle = BorderStyle.Solid;
            txtTableFullName.BorderColor = Color.LightGray;
            txtTablePW.BorderStyle = BorderStyle.Solid;
            txtTablePW.BorderColor = Color.LightGray;
            txtTablePhoneNumber.BorderStyle = BorderStyle.Solid;
            txtTablePhoneNumber.BorderColor = Color.LightGray;
            txtTableEmailAddress.BorderStyle = BorderStyle.Solid;
            txtTableEmailAddress.BorderColor = Color.LightGray;
            txtTableAddress.BorderStyle = BorderStyle.Solid;
            txtTableAddress.BorderColor = Color.LightGray;
            txtTableZipCode.BorderStyle = BorderStyle.Solid;
            txtTableZipCode.BorderColor = Color.LightGray;
            txtTableDOB.BorderStyle = BorderStyle.Solid;
            txtTableDOB.BorderColor = Color.LightGray;
        }

        protected void btnEditProfile_Click(object sender, EventArgs e)
        {
            enableTableTextBoxes();
            btnConfirmUpdate.Visible = true;
            btnEditProfile.Visible = false;
            btnEditCancel.Visible = true;
        }

        protected void menuTabs_MenuItemClick(object sender, MenuEventArgs e)
        {
            multiTabs.ActiveViewIndex = Int32.Parse(menuTabs.SelectedValue);
        }

        protected void btnEditCancel_Click(object sender, EventArgs e)
        {
            retrieveUserDetail();
            btnConfirmUpdate.Visible = false;
            btnEditProfile.Visible = true;
            btnEditCancel.Visible = false;
        }

        protected void btnConfirmUpdate_Click(object sender, EventArgs e)
        {
            updateUserDetail();
            retrieveUserDetail();
            btnConfirmUpdate.Visible = false;
            btnEditProfile.Visible = true;
            btnEditCancel.Visible = false;
        }

        private void GetOrderDetail()
        {
            cmd = new SqlCommand("SELECT distinct OrderDate, OrderNo, dense_rank() OVER(ORDER BY OrderDate DESC) as '#' FROM Orders WHERE Username=@Username ORDER BY OrderDate DESC", con);
            cmd.Parameters.AddWithValue("@Username", Session["username"]);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rOrder.DataSource = dt;
            rOrder.DataBind();
        }

        private DataTable GetOrderHistory(string orderNo)
        {
            cmd = new SqlCommand("select o.OrderNo, o.OrderDate, a.Name, Max(a.Price) as Price, Max(o.Quantity) as Quantity," +
                "sum(a.Price * o.Quantity) as TotalPrice, Max(o.status) as Status from Orders o, Artworks a " +
                "where a.ArtworkId = o.ArtworkId and o.Username = @Username and o.OrderNo= @OrderNo group by o.OrderNo, a.Name, o.OrderDate " +
                "order by o.OrderDate DESC", con);
            cmd.Parameters.AddWithValue("@Username", Session["username"]);
            cmd.Parameters.AddWithValue("@OrderNo", orderNo);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            return dt;
        }

        protected void rOrder_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                string orderNo = (e.Item.FindControl("lblOrderNo") as Label).Text;
                Repeater rHistory = e.Item.FindControl("rHistory") as Repeater;
                rHistory.DataSource = GetOrderHistory(orderNo);
                rHistory.DataBind();
            }
        }

        protected void rHistory_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblStatus = e.Item.FindControl("lblStatus") as Label;
                if (lblStatus.Text == "Pending")
                {
                    lblStatus.CssClass = "badge-pill badge-secondary";
                } 
                else if (lblStatus.Text == "Dispatched")
                {
                    lblStatus.CssClass = "badge badge-pill badge-warning";
                } 
                else
                {
                    lblStatus.CssClass = "badge badge-pill badge-success";
                }
            }
        }

        protected void rOrder_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ViewInvoice")
            {
                Session["orderId"] = e.CommandArgument.ToString();
                Response.Redirect("Invoice.aspx");
            }
        }
    }
}