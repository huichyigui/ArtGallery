using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.IO;

namespace ArtGallery.Artist
{
    public partial class OrderStatus : System.Web.UI.Page
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
                Session["breadCrumb"] = "Update Status";
                GetDeliveryOrder();
            }
            lblMsg.Visible = false;
        }

        private void GetDeliveryOrder()
        {
            cmd = new SqlCommand("select o.OrderDetailsId, o.OrderNo, o.OrderDate, o.Status, a.Name as 'ArtworkName', " +
                "sum(a.Price * o.Quantity) as 'TotalPrice' FROM orders o, artworks a where o.ArtworkId = a.ArtworkId " +
                "AND a.Username = @Username " +
                "group by o.OrderDetailsId, o.OrderNo, o.OrderDate, o.Status, a.Name", con);
            cmd.Parameters.AddWithValue("@Username", Session["username"]);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rOrderList.DataSource = dt;
            rOrderList.DataBind();
        }

        protected void rOrderList_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblMsg.Visible = false;
            if (e.CommandName == "edit")
            {
                pnUpdateStatus.Visible = true;
                cmd = new SqlCommand("select o.OrderNo, o.OrderDate, o.Status, a.Name, a.ImageUrl " +
                    "FROM orders o, artworks a where o.ArtworkId = a.ArtworkId " +
                    "AND a.Username = @Username AND o.OrderDetailsId = @OrderDetailsId", con);
                cmd.Parameters.AddWithValue("@Username", Session["username"]);
                cmd.Parameters.AddWithValue("@OrderDetailsId", e.CommandArgument);
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                hdnOrderDetailsId.Value = e.CommandArgument.ToString();
                lblOrderNo.Text = dt.Rows[0]["OrderNo"].ToString();
                lblOrderDate.Text = dt.Rows[0]["OrderDate"].ToString();
                lblArtworkName.Text = dt.Rows[0]["Name"].ToString();
                ddlStatus.SelectedValue = dt.Rows[0]["Status"].ToString();
                imgArtwork.ImageUrl = string.IsNullOrEmpty(dt.Rows[0]["ImageUrl"].ToString()) ? "~/Images/No_image.png" : dt.Rows[0]["ImageUrl"].ToString();
                imgArtwork.Height = 200;
                imgArtwork.Width = 200;
                LinkButton btn = e.Item.FindControl("lnkEdit") as LinkButton;
                btn.CssClass = "badge badge-warning";
            }
        }

        protected void rOrderList_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblIsActive = e.Item.FindControl("lblStatus") as Label;
                if (lblIsActive.Text == "Pending")
                {
                    lblIsActive.CssClass = "badge badge-secondary";
                }
                else if (lblIsActive.Text == "Dispatched")
                {
                    lblIsActive.CssClass = "badge badge-primary";
                } 
                else if (lblIsActive.Text == "Delivered")
                {
                    lblIsActive.CssClass = "badge badge-success";
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand("UPDATE Orders SET Status=@Status WHERE OrderDetailsId=@OrderDetailsId", con);
            cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@OrderDetailsId", hdnOrderDetailsId.Value);

            int n = cmd.ExecuteNonQuery();
            if (n > 0)
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Order <b>" + lblOrderNo.Text + "</b> Status Updated!";
                lblMsg.CssClass = "alert alert-success";
                GetDeliveryOrder();
                pnUpdateStatus.Visible = false;
            } 
            else
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Ops! Unable to update record.";
                lblMsg.CssClass = "alert alert-danger";
            }
            con.Close();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            pnUpdateStatus.Visible = false;
        }
    }
}