using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;
using System.Globalization;

namespace ArtGallery
{
    public partial class UserRegistration : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(Connection.GetConnectionString());
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                string imagePath = string.Empty, fileExtension = string.Empty;

                //Check duplicate username if any
                lblErrorMessage.Visible = false;
                String query = "SELECT COUNT(1) FROM Users WHERE Username=@username";
                SqlCommand sqlCmd = new SqlCommand(query, con);
                sqlCmd.Parameters.AddWithValue("@username", txtUsername.Text.Trim());
                con.Open();
                int count = Convert.ToInt32(sqlCmd.ExecuteScalar());
                con.Close();
                if (count == 1) //If found then prompt error else proceed to create new account
                {
                    lblErrorMessage.Visible = true;
                    lblErrorMessage.Text = "Please amend your username as it has been taken.";
                    return;
                }
                else
                {
                    sqlCmd = new SqlCommand("INSERT INTO Users (Username, Password, RoleType, Name, Mobile, DOB, EmailAddress, Gender, PhysicalAddress, ZipCode, ImageUrl, CreatedDate) " +
                        "VALUES (@Username, @Password, @RoleType, @Name, @Mobile, @DOBs, @EmailAddress, @Gender, @PhysicalAddress, @ZipCode, @ImageUrl, @CreatedDate)", con);
                    sqlCmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());

                    //Make sure both password is equal
                    bool comparePassword = txtPassword.Text.Trim().Equals(txtConfirmPassword.Text.Trim());
                    if (comparePassword)
                    {
                        sqlCmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
                    }
                    else
                    {
                        lblErrorMessage.Visible = true;
                        lblErrorMessage.Text = "Incorrect password. Please double check.";
                        return;
                    }

                    if (ddlUserType.SelectedIndex == 1)
                    {
                        sqlCmd.Parameters.AddWithValue("@RoleType", "Artist");
                    }
                    else
                    {
                        sqlCmd.Parameters.AddWithValue("@RoleType", "Customer");
                    }

                    sqlCmd.Parameters.AddWithValue("@Name", txtFullName.Text.Trim());
                    sqlCmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());

                    string dobs = txtDOB.Text.Trim();
                    if (CultureInfo.CurrentCulture.Name == "en-US")
                    {
                        string[] strArrOldFormat = dobs.Split('/');
                        string strNewFormat = strArrOldFormat[1] + "/" + strArrOldFormat[0] + "/" + strArrOldFormat[2];
                        sqlCmd.Parameters.AddWithValue("@DOBs", Convert.ToDateTime(strNewFormat));
                    }
                    else
                    {
                        System.DateTime appTime = DateTime.Parse(dobs, System.Globalization.CultureInfo.CreateSpecificCulture("en-SG").DateTimeFormat);
                        sqlCmd.Parameters.AddWithValue("@DOBs", Convert.ToDateTime(appTime));
                    }

                    sqlCmd.Parameters.AddWithValue("@EmailAddress", txtEmail.Text.Trim());
                    sqlCmd.Parameters.AddWithValue("@Gender", radGender.SelectedItem.Text.Trim());
                    sqlCmd.Parameters.AddWithValue("@PhysicalAddress", txtAddress.Text);
                    sqlCmd.Parameters.AddWithValue("@ZipCode", txtZipCode.Text.Trim());

                    //Get the image file path
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
                        sqlCmd.Parameters.AddWithValue("@imageUrl", "~/Images/default_user_pic.png");
                    }

                    string createdDate = DateTime.Now.ToShortDateString();
                    sqlCmd.Parameters.AddWithValue("@CreatedDate", Convert.ToDateTime(createdDate));

                    con.Open();
                    int n = sqlCmd.ExecuteNonQuery();
                    if (n > 0)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                            "alert('Successfully registered!');window.location ='Login.aspx';", true);
                    }
                    else
                    {
                        lblErrorMessage.Visible = true;
                        lblErrorMessage.Text = "Ops! Unable to insert record.";
                        return;
                    }
                    con.Close();
                }
            }
            catch (Exception ex)
            {
                lblMsg.Visible = true;
                lblMsg.Text = ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
        }
    }
}