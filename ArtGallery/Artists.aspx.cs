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
    public partial class Artists : System.Web.UI.Page
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
                if (Session["usertype"] == null)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                    "alert('Please log in to view.');window.location ='Login.aspx';", true);
                }
                BindArtist();
            }
        }

        protected void lnkbtnPrevious_Click(object sender, EventArgs e)
        {
            CurrentPage -= 1;
            BindArtist();
        }
        protected void lnkbtnNext_Click(object sender, EventArgs e)
        {
            CurrentPage += 1;
            BindArtist();
        }
        protected void dlPaging_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName.Equals("lnkbtnPaging"))
            {
                CurrentPage = Convert.ToInt16(e.CommandArgument.ToString());
                BindArtist();
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

        void BindArtist()
        {
            string str = "SELECT [UID], [Name], [Username], [ImageUrl] FROM [Users] WHERE ([RoleType] = 'Artist')";
            cmd = new SqlCommand(str, con);
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


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            con.Open();
            sda = new SqlDataAdapter("SELECT * FROM Users WHERE Name LIKE @search AND RoleType='Artist'", con);
            sda.SelectCommand.Parameters.AddWithValue("@search", "%" + txtSearch.Text + "%");
            ds = new DataSet();
            sda.Fill(ds);
            DataList1.DataSourceID = null;
            con.Close();
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
            // Redirect to Artist Detail Page
            if (e.CommandName == "ViewArtistDetail")
            {
                Response.Redirect("ArtistDetail.aspx?id=" + e.CommandArgument.ToString());
            }
        }
    }
}