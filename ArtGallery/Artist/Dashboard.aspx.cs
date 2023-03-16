using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace ArtGallery.Artist
{
    public partial class Dashboard : System.Web.UI.Page
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
                Session["breadCrumb"] = "";
            }
            con.Open();
            SqlCommand cmdCountArt = new SqlCommand("SELECT count(ArtworkId) from Artworks where username = @username", con);
            cmdCountArt.Parameters.AddWithValue("@username", Session["username"]);
            int countArt = (int)cmdCountArt.ExecuteScalar();
            lblCountArt.Text = countArt.ToString();

            SqlCommand cmdCountOrder = new SqlCommand("SELECT count(OrderDetailsId) FROM Orders o, Users u, Artworks a " +
                "WHERE a.Username = u.Username and o.ArtworkId = a.ArtworkId and a.Username = @username", con);
            cmdCountOrder.Parameters.AddWithValue("@username", Session["username"]);
            int countOrder = (int)cmdCountOrder.ExecuteScalar();
            lblCountOrder.Text = countOrder.ToString();

            SqlCommand cmdCountPend = new SqlCommand("SELECT count(OrderDetailsId) FROM Orders o, Users u, Artworks a " +
                "WHERE a.Username = u.Username and o.ArtworkId =  a.ArtworkId and o.status = 'Pending' and a.Username = @username", con);
            cmdCountPend.Parameters.AddWithValue("@username", Session["username"]);
            int countPend = (int)cmdCountPend.ExecuteScalar();
            lblCountPend.Text = countPend.ToString();

            SqlCommand cmdCountDispatch = new SqlCommand("SELECT count(OrderDetailsId) FROM Orders o, Users u, Artworks a " +
                "WHERE a.Username = u.Username and o.ArtworkId =  a.ArtworkId and o.status = 'Dispatched' and a.Username = @username", con);
            cmdCountDispatch.Parameters.AddWithValue("@username", Session["username"]);
            int countDispatch = (int)cmdCountDispatch.ExecuteScalar();
            lblCountDispatch.Text = countDispatch.ToString();

            SqlCommand cmdCountDeliver = new SqlCommand("SELECT count(OrderDetailsId) FROM Orders o, Users u, Artworks a " +
                "WHERE a.Username = u.Username and o.ArtworkId =  a.ArtworkId and o.status = 'Delivered' and a.Username = @username", con);
            cmdCountDeliver.Parameters.AddWithValue("@username", Session["username"]);
            int countDeliver = (int)cmdCountDeliver.ExecuteScalar();
            lblCountDeliver.Text = countDeliver.ToString();

            SqlCommand cmdSoldAmount = new SqlCommand("SELECT sum(a.price * o.quantity) FROM Orders o, Users u, Artworks a " +
                "WHERE a.Username = u.Username and o.ArtworkId = a.ArtworkId and a.Username = @username " +
                "group by a.username", con);
            cmdSoldAmount.Parameters.AddWithValue("@username", Session["username"]);
            object objSoldAmount = cmdSoldAmount.ExecuteScalar();
            if (objSoldAmount != null)
            {
                lblSoldAmount.Text = "RM " + objSoldAmount.ToString();
            }
            else
            {
                lblSoldAmount.Text = "0.00";
            }
            con.Close();
        }
    }
}