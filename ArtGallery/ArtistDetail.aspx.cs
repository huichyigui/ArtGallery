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
    public partial class ArtistDetail : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(Connection.GetConnectionString());
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        DataSet ds;
        PagedDataSource pds = new PagedDataSource();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["username"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                BindArtDetail();
            }
            con.Open();
            cmd = new SqlCommand("SELECT Name From Users WHERE Username=@username", con);
            cmd.Parameters.AddWithValue("@username", Request.QueryString["id"]);
            string name = cmd.ExecuteScalar().ToString();
            con.Close();
            lblArtistName.Text = name;
            lblName.Text = name;

            con.Open();
            SqlCommand cmd2 = new SqlCommand("SELECT COUNT(1) FROM Artworks WHERE Username=@username", con);
            cmd2.Parameters.AddWithValue("@username", Request.QueryString["id"]);
            int count = Convert.ToInt32(cmd2.ExecuteScalar());
            if (count == 0)
            {
                Image1.Visible = true;
                lblName.Visible = true;
                lblMessage.Visible = true;
            }
            else
            {
                Image1.Visible = false;
                lblName.Visible = false;
                lblMessage.Visible = false;
            }
            con.Close();
        }

        protected void lnkbtnPrevious_Click(object sender, EventArgs e)
        {
            CurrentPage -= 1;
            BindArtDetail();
        }
        protected void lnkbtnNext_Click(object sender, EventArgs e)
        {
            CurrentPage += 1;
            BindArtDetail();
        }
        protected void dlPaging_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName.Equals("lnkbtnPaging"))
            {
                CurrentPage = Convert.ToInt16(e.CommandArgument.ToString());
                BindArtDetail();
            }
        }
        protected void dlPaging_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            LinkButton lnkbtnPage = (LinkButton)e.Item.FindControl("lnkbtnPaging");
            if (lnkbtnPage.CommandArgument.ToString() == CurrentPage.ToString())
            {
                lnkbtnPage.Enabled = false;
                lnkbtnPage.Font.Bold = true;
            }
        }

        public int CurrentPage
        {
            get
            {
                if (this.ViewState["CurrentPage"] == null)
                    return 0;
                else
                    return Convert.ToInt16(this.ViewState["CurrentPage"].ToString());
            }
            set
            {
                this.ViewState["CurrentPage"] = value;
            }
        }
        private void doPaging()
        {
            dt = new DataTable();
            dt.Columns.Add("PageIndex");
            dt.Columns.Add("PageText");
            for (int i = 0; i < pds.PageCount; i++)
            {
                DataRow dr = dt.NewRow();
                dr[0] = i;
                dr[1] = i + 1;
                dt.Rows.Add(dr);
            }
            dlPaging.DataSource = dt;
            dlPaging.DataBind();
        }

        private void BindArtDetail()
        {
            string str = "SELECT a.*, u.Name as 'ArtistName', c.Name as 'CategoryName' FROM Artworks a, Users u, Categories c WHERE a.Username = u.Username AND c.CategoryId = a.CategoryId AND a.isActive = 'True' AND a.Username=@Username";
            cmd = new SqlCommand(str, con);
            cmd.Parameters.AddWithValue("@Username", Request.QueryString["id"]);
            sda = new SqlDataAdapter(cmd);
            ds = new DataSet();
            sda.Fill(ds);
            DataList1.DataSource = ds;
            DataList1.DataBind();
            pds.DataSource = ds.Tables[0].DefaultView;
            pds.AllowPaging = true;
            pds.PageSize = 8;
            pds.CurrentPageIndex = CurrentPage;
            lnkbtnNext.Enabled = !pds.IsLastPage;
            lnkbtnPrevious.Enabled = !pds.IsFirstPage;
            DataList1.DataSource = pds;
            DataList1.DataBind();
            doPaging();
        }

        protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
        {
            // Add to Wishlist
            Session["addWishlist"] = "true";
            if (e.CommandName == "AddToWishlist")
            {
                Response.Redirect("Wishlist.aspx?id=" + e.CommandArgument.ToString());
            }

            // Add to Cart
            Session["addArtwork"] = "true";
            if (e.CommandName == "AddToCart")
            {
                DropDownList quantity = (DropDownList)(e.Item.FindControl("ddlQuantity"));
                Response.Redirect("Cart.aspx?id=" + e.CommandArgument.ToString() + "&quantity=" + quantity.SelectedItem.ToString());
            }
        }

        protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            HiddenField artworkId = e.Item.FindControl("hdnArtworkId") as HiddenField;
            Label stock = e.Item.FindControl("lblStock") as Label;
            Button btn = e.Item.FindControl("btnCart") as Button;
            DropDownList selectedQuantity = (DropDownList)e.Item.FindControl("ddlQuantity") as DropDownList;
            con.Open();
            sda = new SqlDataAdapter("SELECT * FROM Artworks WHERE ArtworkId=@id", con);
            sda.SelectCommand.Parameters.AddWithValue("@id", artworkId.Value);
            dt = new DataTable();
            sda.Fill(dt);
            string stockData = null;
            if (dt.Rows.Count > 0)
            {
                stockData = dt.Rows[0]["Quantity"].ToString();
            }
            con.Close();

            if (stockData == "0")
            {
                stock.Text = "Sold Out";
                stock.CssClass = "badge-pill badge-danger";
                btn.Enabled = false;
                btn.Text = "Sold Out";
                btn.CssClass = "btn-art btn-danger";
                selectedQuantity.Enabled = false;
            }
            else
            {
                stock.Text = "Stock: " + stockData;
                stock.CssClass = "badge-pill badge-success";
            }
        }
    }
}