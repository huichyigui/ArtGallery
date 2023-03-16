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
    public partial class Wishlist : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(Connection.GetConnectionString());
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        DataSet ds;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["username"] == null)
                {
                    Response.Redirect("Login.aspx");
                }

                dt = new DataTable();
                DataRow dr;
                dt.Columns.Add("No");
                dt.Columns.Add("ArtworkId");
                dt.Columns.Add("Name");
                dt.Columns.Add("ImageUrl");
                dt.Columns.Add("Price");
                if (Request.QueryString["id"] != null)
                {
                    if (Session["WishlistArt"] == null)
                    {
                        dr = dt.NewRow();
                        sda = new SqlDataAdapter("SELECT * FROM Artworks WHERE ArtworkId=@id", con);
                        sda.SelectCommand.Parameters.AddWithValue("@id", Request.QueryString["id"]);
                        DataSet ds = new DataSet();
                        sda.Fill(ds);
                        dr["No"] = 1;
                        dr["ArtworkId"] = ds.Tables[0].Rows[0]["ArtworkId"].ToString();
                        dr["Name"] = ds.Tables[0].Rows[0]["Name"].ToString();
                        dr["ImageUrl"] = ds.Tables[0].Rows[0]["ImageUrl"].ToString();
                        dr["Price"] = ds.Tables[0].Rows[0]["Price"].ToString();
                        dt.Rows.Add(dr);

                        con.Open();
                        cmd = new SqlCommand("INSERT INTO Wishlists VALUES(@ArtworkId, @Username)", con);
                        cmd.Parameters.AddWithValue("@ArtworkId", dr["ArtworkId"]);
                        cmd.Parameters.AddWithValue("@Username", Session["username"]);
                        cmd.ExecuteNonQuery();
                        con.Close();

                        grvWishlist.DataSource = dt;
                        grvWishlist.DataBind();
                        Session["WishlistArt"] = dt;
                        Response.Redirect("Wishlist.aspx");
                    }
                    else
                    {
                        dt = (DataTable)Session["WishlistArt"];
                        bool isTrue = false;
                        int intNo = dt.Rows.Count;
                        dr = dt.NewRow();
                        sda = new SqlDataAdapter("SELECT * FROM Artworks WHERE ArtworkId=@id", con);
                        sda.SelectCommand.Parameters.AddWithValue("@id", Request.QueryString["id"]);
                        ds = new DataSet();
                        sda.Fill(ds);
                        int exist = Convert.ToInt32(ds.Tables[0].Rows[0]["ArtworkId"].ToString());
                        for (int i = 0; i <= dt.Rows.Count - 1; i++)
                        {
                            int artworkId = Convert.ToInt32(dt.Rows[i]["ArtworkId"].ToString());
                            if (exist == artworkId)
                            {
                                isTrue = true;
                                break;
                            }
                        }
                        if (!isTrue)
                        {
                            dr["No"] = intNo + 1;
                            dr["ArtworkId"] = ds.Tables[0].Rows[0]["ArtworkId"].ToString();
                            dr["Name"] = ds.Tables[0].Rows[0]["Name"].ToString();
                            dr["ImageUrl"] = ds.Tables[0].Rows[0]["ImageUrl"].ToString();
                            dr["Price"] = ds.Tables[0].Rows[0]["Price"].ToString();
                            dt.Rows.Add(dr);
                            con.Open();
                            cmd = new SqlCommand("INSERT INTO Wishlists VALUES(@ArtworkId, @Username)", con);
                            cmd.Parameters.AddWithValue("@ArtworkId", dr["ArtworkId"]);
                            cmd.Parameters.AddWithValue("@Username", Session["username"]);
                            cmd.ExecuteNonQuery();
                            con.Close();

                            grvWishlist.DataSource = dt;
                            grvWishlist.DataBind();
                            Session["WishlistArt"] = dt;
                            Response.Redirect("Wishlist.aspx");
                        }
                        else
                        {
                            DataTable dt2 = new DataTable();
                            dt2 = (DataTable)Session["WishlistArt"];
                            for (int i = 0; i <= dt2.Rows.Count - 1; i++)
                            {
                                int id;
                                int artId;
                                string artData = Request.QueryString["id"].ToString();
                                artId = Convert.ToInt32(artData);
                                id = Convert.ToInt32(dt2.Rows[i]["ArtworkId"].ToString());
                                if (id == artId)
                                {
                                    dt2.Rows[i].Delete();
                                    dt2.AcceptChanges();
                                    con.Open();
                                    cmd = new SqlCommand("DELETE FROM Wishlists WHERE ArtworkId=@id AND Username=@username", con);
                                    cmd.Parameters.AddWithValue("@id", artId);
                                    cmd.Parameters.AddWithValue("@username", Session["username"]);
                                    cmd.ExecuteNonQuery();
                                    con.Close();
                                    break;
                                }
                            }
                            Session["WishlistArt"] = dt2;
                            Response.Redirect("Wishlist.aspx");
                        }
                    }
                }
                else
                {
                    dt = (DataTable)Session["WishlistArt"];
                    grvWishlist.DataSource = dt;
                    grvWishlist.DataBind();
                }
            }
            if (grvWishlist.Rows.Count.ToString() == "0")
            {
                btnClearWishlist.Enabled = false;
                btnClearWishlist.Style.Add("opacity", "0.4");
            }
            else
            {
                btnClearWishlist.Enabled = true;
            }
        }

        protected void btnClearWishlist_Click(object sender, EventArgs e)
        {
            Session["WishlistArt"] = null;
            ClearWishlist();
        }

        private void ClearWishlist()
        {
            con.Open();
            cmd = new SqlCommand("DELETE FROM Wishlists WHERE Username=@username", con);
            cmd.Parameters.AddWithValue("@username", Session["username"]);
            cmd.ExecuteNonQuery();
            con.Close();
            Response.Redirect("Wishlist.aspx");
        }

        protected void grvWishlist_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            dt = new DataTable();
            dt = (DataTable)Session["WishlistArt"];
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                int intNo;
                int intNo2;
                int artworkId = Convert.ToInt16(dt.Rows[i]["ArtworkId"]);
                string qdata;
                string dtdata;
                intNo = Convert.ToInt32(dt.Rows[i]["No"].ToString());
                TableCell cell = grvWishlist.Rows[e.RowIndex].Cells[0];
                qdata = cell.Text;
                dtdata = intNo.ToString();
                intNo2 = Convert.ToInt32(qdata);
                TableCell artId = grvWishlist.Rows[e.RowIndex].Cells[1];

                if (intNo == intNo2)
                {
                    dt.Rows[i].Delete();
                    dt.AcceptChanges();

                    con.Open();
                    cmd = new SqlCommand("DELETE TOP(1) FROM Wishlists WHERE ArtworkId=@artworkId AND Username=@username", con);
                    cmd.Parameters.AddWithValue("@artworkId", artworkId);
                    cmd.Parameters.AddWithValue("@username", Session["username"]);
                    cmd.ExecuteNonQuery();
                    con.Close();

                    break;
                }
            }
            for (int i = 1; i <= dt.Rows.Count; i++)
            {
                dt.Rows[i - 1]["No"] = i;
                dt.AcceptChanges();
            }
            Session["WishlistArt"] = dt;
            Response.Redirect("Wishlist.aspx");
        }
    }
}