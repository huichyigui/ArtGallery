using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Net.Mail;

namespace ArtGallery
{
    public partial class ForgetPassword : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(Connection.GetConnectionString());
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnResetAccountPW_Click(object sender, EventArgs e)
        {
            try
            {
                String query;
                String updatePasswordQuery;
                if (ddlResetAccountType.SelectedIndex == 1)
                {
                    query = "SELECT COUNT(1) FROM Users WHERE Username=@username AND EmailAddress=@emailaddress AND RoleType='Artist'";
                    updatePasswordQuery = "UPDATE Users SET Password=@password WHERE Username=@username AND RoleType='Artist'";
                }
                else
                {
                    query = "SELECT COUNT(1) FROM Users WHERE Username=@username AND EmailAddress=@emailaddress AND RoleType='Customer'";
                    updatePasswordQuery = "UPDATE Users SET Password=@password WHERE Username=@username AND RoleType='Customer'";
                }

                SqlCommand sqlCmd = new SqlCommand(query, con);
                sqlCmd.Parameters.AddWithValue("@username", txtResetUserName.Text.Trim());
                sqlCmd.Parameters.AddWithValue("@emailaddress", txtResetUserEmailAddress.Text.Trim());
                con.Open();
                int count = Convert.ToInt32(sqlCmd.ExecuteScalar());
                con.Close();

                if (count == 1)
                {
                    //Reset current Password to random string
                    String newPassword = RandomString(8);

                    SqlCommand sqlCmd1 = new SqlCommand(updatePasswordQuery, con);
                    sqlCmd1.Parameters.AddWithValue("@username", txtResetUserName.Text.Trim());
                    sqlCmd1.Parameters.AddWithValue("@password", newPassword);
                    con.Open();
                    sqlCmd1.ExecuteNonQuery();
                    con.Close();

                    //Send the email
                    using (MailMessage mail = new MailMessage())
                    {
                        mail.From = new MailAddress("dummyliciousx@gmail.com");

                        String getEmailAddressQuery = "SELECT EmailAddress FROM Users WHERE Username=@username";
                        SqlCommand sqlCmd2 = new SqlCommand(getEmailAddressQuery, con);
                        sqlCmd2.Parameters.AddWithValue("@username", txtResetUserName.Text.Trim());
                        con.Open();
                        SqlDataReader dtrreader = sqlCmd2.ExecuteReader();
                        dtrreader.Read();
                        String obtainedEmailAddress = dtrreader[0].ToString();
                        con.Close();

                        mail.To.Add(obtainedEmailAddress);
                        mail.Subject = "Le Louvre Gallery: Reset Password";

                        System.Text.StringBuilder sb = new System.Text.StringBuilder();
                        sb.Append("<p>Dear " + txtResetUserName.Text + ",</br></br> </br></p>");
                        sb.Append("<p>We have received a request to reset your current password. </br></p>");
                        sb.Append("<p>Your latest password: " + newPassword + "</br> </br></p>");
                        sb.Append("<p>Please use this latest password to sign in and change your password immediately. </br></br></br></p>");
                        sb.Append("<p></br></p>");
                        sb.Append("<p>Regards, </br></p>");
                        sb.Append("<p>Le Louvre Gallery Team</p>");

                        mail.Body = sb.ToString();
                        mail.IsBodyHtml = true;

                        using (SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587))
                        {
                            smtp.Credentials = new System.Net.NetworkCredential("dummyliciousx@gmail.com", "Dummy123!!");
                            smtp.EnableSsl = true;
                            smtp.Send(mail);
                        }
                    }

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                        "alert('Password Reset Mail Sent. Cheers!');window.location ='Login.aspx';", true);
                }
                else
                {
                    lblResetAccountError.Visible = true;
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }

        //For generate random string function
        private static Random random = new Random();
        public static string RandomString(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            return new string(Enumerable.Range(1, length).Select(_ =>
            chars[random.Next(chars.Length)]).ToArray());
        }
    }
}