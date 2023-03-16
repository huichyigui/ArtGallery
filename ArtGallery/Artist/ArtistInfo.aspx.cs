using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;
using System.Drawing;

namespace ArtGallery.Artist
{
    public partial class ArtistInfo : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(Connection.GetConnectionString());
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["username"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                }
                Session["breadCrumb"] = "Profile";
                retrieveUserDetail();
            }
            lblMsg.Visible = false;
        }

        private void retrieveUserDetail()
        {
            con.Open();
            SqlCommand retrievecmd = new SqlCommand("SELECT Username, EmailAddress, Name, Password, Mobile, DOB, PhysicalAddress, ZipCode, ImageUrl, CreatedDate, Gender FROM Users WHERE Username=@username", con);
            retrievecmd.Parameters.AddWithValue("@username", Session["username"].ToString());
            using (SqlDataReader dr = retrievecmd.ExecuteReader())
            {
                dr.Read();
                lblArtistUserName.Text = dr["Username"].ToString();
                lblArtistEmail.Text = dr["EmailAddress"].ToString();
                string strNewFormat = dr["CreatedDate"].ToString();
                lblArtistCreatedDate.Text = "Artist since " + strNewFormat.Substring(0, 10);
                imgProfile.ImageUrl = dr["ImageUrl"].ToString();
                txtArtistFullName.Text = dr["Name"].ToString();
                txtArtistPW.Text = dr["Password"].ToString();
                txtArtistPhoneNumber.Text = dr["Mobile"].ToString();
                txtArtistEmailAddress.Text = dr["EmailAddress"].ToString();
                txtArtistAddress.Text = dr["PhysicalAddress"].ToString();
                txtArtistZipCode.Text = dr["ZipCode"].ToString();

                //Parse datetime 
                string conv = dr["DOB"].ToString();
                conv = DateTime.Parse(conv).ToString("yyyy-MM-dd");
                txtArtistDOB.Text = conv.ToString();

                string gender = dr["Gender"].ToString();
                if (gender == "Male")
                {
                    radArtistInfoGender.SelectedValue = "Male";
                }
                else
                    radArtistInfoGender.SelectedValue = "Female";
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

            sqlCmd.Parameters.AddWithValue("@name", txtArtistFullName.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@password", txtArtistPW.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@mobile", txtArtistPhoneNumber.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@DOBs", txtArtistDOB.Text);
            sqlCmd.Parameters.AddWithValue("@emailAddress", txtArtistEmailAddress.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@gender", radArtistInfoGender.SelectedItem.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@physicalAddress", txtArtistAddress.Text);
            sqlCmd.Parameters.AddWithValue("@zipCode", txtArtistZipCode.Text.Trim());

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
                    lblMsg.Visible = true;
                    lblMsg.Text = "Please select .jpg, .jpeg, .png image.";
                    lblMsg.CssClass = "alert alert-danger";
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
                lblMsg.Visible = true;
                lblMsg.Text = "Profile Updated Successfully!";
                lblMsg.CssClass = "alert alert-success";
            }
            else
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Ops! Unable to update record.";
                lblMsg.CssClass = "alert alert-danger";
            }
            con.Close();
        }

        private void disableTableTextBoxes()
        {
            txtArtistFullName.Enabled = false;

            txtArtistPW.Attributes["type"] = "password";
            txtArtistPW.Enabled = false;
            txtArtistPhoneNumber.Enabled = false;
            txtArtistEmailAddress.Enabled = false;
            txtArtistAddress.Enabled = false;
            txtArtistZipCode.Enabled = false;
            txtArtistDOB.Enabled = false;
            fuProfileImage.Visible = false;
            fuProfileImage.Enabled = false;
            radArtistInfoGender.Enabled = false;

            txtArtistFullName.BorderStyle = BorderStyle.None;
            txtArtistPW.BorderStyle = BorderStyle.None;
            txtArtistPhoneNumber.BorderStyle = BorderStyle.None;
            txtArtistEmailAddress.BorderStyle = BorderStyle.None;
            txtArtistAddress.BorderStyle = BorderStyle.None;
            txtArtistZipCode.BorderStyle = BorderStyle.None;
            txtArtistDOB.BorderStyle = BorderStyle.None;
        }
        private void enableTableTextBoxes()
        {
            txtArtistFullName.Enabled = true;
            txtArtistPW.Enabled = true;
            txtArtistPhoneNumber.Enabled = true;
            txtArtistEmailAddress.Enabled = true;
            txtArtistAddress.Enabled = true;
            txtArtistZipCode.Enabled = true;
            txtArtistDOB.Enabled = true;
            fuProfileImage.Visible = true;
            fuProfileImage.Enabled = true;
            radArtistInfoGender.Enabled = true;
            txtArtistPW.Attributes["type"] = "SingleLine";

            txtArtistFullName.BorderStyle = BorderStyle.Solid;
            txtArtistFullName.BorderColor = Color.LightGray;
            txtArtistPW.BorderStyle = BorderStyle.Solid;
            txtArtistPW.BorderColor = Color.LightGray;
            txtArtistPhoneNumber.BorderStyle = BorderStyle.Solid;
            txtArtistPhoneNumber.BorderColor = Color.LightGray;
            txtArtistEmailAddress.BorderStyle = BorderStyle.Solid;
            txtArtistEmailAddress.BorderColor = Color.LightGray;
            txtArtistAddress.BorderStyle = BorderStyle.Solid;
            txtArtistAddress.BorderColor = Color.LightGray;
            txtArtistZipCode.BorderStyle = BorderStyle.Solid;
            txtArtistZipCode.BorderColor = Color.LightGray;
            txtArtistDOB.BorderStyle = BorderStyle.Solid;
            txtArtistDOB.BorderColor = Color.LightGray;
        }

        protected void btnArtistEditProfile_Click(object sender, EventArgs e)
        {
            enableTableTextBoxes();
            btnArtistConfirmUpdate.Visible = true;
            btnArtistEditProfile.Visible = false;
            btnArtistCancel.Visible = true;
        }

        protected void btnArtistConfirmUpdate_Click(object sender, EventArgs e)
        {
            updateUserDetail();
            retrieveUserDetail();
            btnArtistConfirmUpdate.Visible = false;
            btnArtistEditProfile.Visible = true;
            btnArtistCancel.Visible = false;
        }

        protected void btnArtistCancel_Click(object sender, EventArgs e)
        {
            retrieveUserDetail();
            btnArtistConfirmUpdate.Visible = false;
            btnArtistEditProfile.Visible = true;
            btnArtistCancel.Visible = false;
        }
    }
}