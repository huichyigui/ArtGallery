using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Globalization;

namespace ArtGallery.Artist
{
    public partial class Report : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(Connection.GetConnectionString());
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["username"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                }
                Session["breadCrumb"] = "Report";
                lblMsg.Visible = false;
            }
        }

        private void GetReport()
        {
            try
            {
                con.Open();
                cmd = new SqlCommand("select ROW_NUMBER() OVER(ORDER BY u.Name) as '#', u.Name, u.EmailAddress, sum(o.Quantity) as ItemOrders, sum(o.Quantity*a.Price) as TotalCost from Orders o, Users u, Artworks a " +
                    "where o.ArtworkId = a.ArtworkId and o.Username = u.Username and " +
                    "a.Username = @Username and cast(OrderDate as date) between @FromDate and @ToDate " +
                "group by u.Name, u.EmailAddress", con);
                cmd.Parameters.AddWithValue("@Username", Session["username"]);
                cmd.Parameters.AddWithValue("@FromDate", txtFromDate.Text);
                cmd.Parameters.AddWithValue("@ToDate", Convert.ToDateTime(txtFromDate.Text).AddDays(1));
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                rReport.DataSource = dt;
                rReport.DataBind();
            } catch(Exception ex) {
                lblMsg.Visible = true;
                lblMsg.Text = ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            } finally
            {
                con.Close();
            }
        }

        private void GetRangeSale()
        {
            try
            {
                con.Open();
                cmd = new SqlCommand("select a.Username, sum(o.Quantity*a.Price) as 'TotalSale' from Orders o, Users u, Artworks a " +
                    "where o.ArtworkId = a.ArtworkId and o.Username = u.Username and " +
                    "a.Username = @Username and cast(OrderDate as date) between @FromDate and @ToDate " +
                "group by a.Username", con);
                cmd.Parameters.AddWithValue("@Username", Session["username"]);
                cmd.Parameters.AddWithValue("@FromDate", txtFromDate.Text);
                cmd.Parameters.AddWithValue("@ToDate", Convert.ToDateTime(txtFromDate.Text).AddDays(1));
                SqlDataReader dtr = cmd.ExecuteReader();
                if (dtr.HasRows)
                {
                    if (dtr.Read())
                    {
                        lblAmount.Visible = true;
                        lblAmount.Text = "Sold Cost: RM " + dtr["TotalSale"].ToString();
                        lblAmount.CssClass = "badge badge-primary";
                    }
                } else
                {
                    lblAmount.Visible = false;
                }
            }
            catch (Exception ex)
            {
                lblMsg.Visible = true;
                lblMsg.Text = ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
            finally
            {
                con.Close();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (txtFromDate.Text != null && txtToDate.Text != null)
            {
                pnReport.Visible = true;
                GetReport();
                GetRangeSale();
            } 
            else
            {
                Response.Write("<script>alert('Please select From Date and To Date to generate report.');</script>");
            }
        }
    }
}