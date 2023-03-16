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
    public partial class Artwork : System.Web.UI.Page
    {
        SqlConnection con;
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
                Session["breadCrumb"] = "Artworks";
                GetArtworks();
            }
            lblMsg.Visible = false;
        }

        private void GetArtworks()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Artwork_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT");
            cmd.Parameters.AddWithValue("@Username", Session["username"]);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rArtwork.DataSource = dt;
            rArtwork.DataBind();
        }

        protected void btnAddOrUpdate_Click(object sender, EventArgs e)
        {
            string actionName = string.Empty, imagePath = string.Empty, fileExtension = string.Empty;
            bool isValidToExecute = false;
            int artworkId = Convert.ToInt32(hdnId.Value);
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Artwork_Crud", con);
            cmd.Parameters.AddWithValue("@Action", artworkId == 0 ? "INSERT" : "UPDATE");
            cmd.Parameters.AddWithValue("@ArtworkId", artworkId);
            cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
            cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
            cmd.Parameters.AddWithValue("@Price", txtPrice.Text.Trim());
            cmd.Parameters.AddWithValue("@Quantity", txtQuantity.Text.Trim());
            cmd.Parameters.AddWithValue("@CategoryId", ddlCategory.SelectedValue);
            cmd.Parameters.AddWithValue("@IsActive", cbIsActive.Checked);
            cmd.Parameters.AddWithValue("@Username", Session["username"]);
            if (fuArtworkImage.HasFile)
            {
                if (Utils.isValidExtension(fuArtworkImage.FileName))
                {
                    Guid obj = Guid.NewGuid();
                    fileExtension = Path.GetExtension(fuArtworkImage.FileName);
                    imagePath = "~/Images/Artwork/" + obj.ToString() + fileExtension;
                    fuArtworkImage.PostedFile.SaveAs(Server.MapPath("~/Images/Artwork/") + obj.ToString() + fileExtension);
                    cmd.Parameters.AddWithValue("@ImageUrl", imagePath);
                    isValidToExecute = true;
                }
                else
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Please select .jpg, .jpeg, .png image.";
                    lblMsg.CssClass = "alert alert-danger";
                    isValidToExecute = false;
                }
            }
            else
            {
                if (imgArtwork.ImageUrl == null)
                {
                    cmd.Parameters.AddWithValue("@ImageUrl", "~/Images/No_image.png");
                    isValidToExecute = true;
                } 
                else
                {
                    isValidToExecute = true;
                }
            }

            if (isValidToExecute)
            {
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    actionName = artworkId == 0 ? "inserted" : "updated";
                    lblMsg.Visible = true;
                    lblMsg.Text = "Artwork <b>" + txtName.Text.Trim() + "</b> " + actionName + " successfully!";
                    lblMsg.CssClass = "alert alert-success";
                    GetArtworks();
                    Clear();
                }
                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Error-" + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                }
                finally
                {
                    con.Close();
                }
            }
        }

        private void Clear()
        {
            txtName.Text = string.Empty;
            txtDescription.Text = string.Empty;
            txtPrice.Text = string.Empty;
            txtQuantity.Text = string.Empty;
            ddlCategory.ClearSelection();
            cbIsActive.Checked = false;
            hdnId.Value = "0";
            btnAddOrUpdate.Text = "Add";
            imgArtwork.ImageUrl = string.Empty;
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        protected void rArtwork_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblMsg.Visible = false;
            con = new SqlConnection(Connection.GetConnectionString());
            if (e.CommandName == "edit")
            {
                cmd = new SqlCommand("Artwork_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "GETBYID");
                cmd.Parameters.AddWithValue("@ArtworkId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                txtName.Text = dt.Rows[0]["Name"].ToString();
                txtDescription.Text = dt.Rows[0]["Description"].ToString();
                txtPrice.Text = dt.Rows[0]["Price"].ToString();
                txtQuantity.Text = dt.Rows[0]["Quantity"].ToString();
                ddlCategory.SelectedValue = dt.Rows[0]["CategoryId"].ToString();
                cbIsActive.Checked = Convert.ToBoolean(dt.Rows[0]["IsActive"]);
                imgArtwork.ImageUrl = string.IsNullOrEmpty(dt.Rows[0]["ImageUrl"].ToString()) ? "~/Images/No_image.png" : dt.Rows[0]["ImageUrl"].ToString();
                imgArtwork.Height = 200;
                imgArtwork.Width = 200;
                hdnId.Value = dt.Rows[0]["ArtworkId"].ToString();
                btnAddOrUpdate.Text = "Update";
                LinkButton btn = e.Item.FindControl("lnkEdit") as LinkButton;
                btn.CssClass = "badge badge-warning";
            }
            else if (e.CommandName == "delete")
            {
                cmd = new SqlCommand("Artwork_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "DELETE");
                cmd.Parameters.AddWithValue("@ArtworkId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Visible = true;
                    lblMsg.Text = "Artwork <b>" + txtName.Text.Trim() + "</b> deleted successfully!";
                    lblMsg.CssClass = "alert alert-success";
                    GetArtworks();
                    Clear();
                }
                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Error-" + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                }
                finally
                {
                    con.Close();
                }
            }
        }

        protected void rArtwork_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblIsActive = e.Item.FindControl("lblIsActive") as Label;
                Label lblQuantity = e.Item.FindControl("lblQuantity") as Label;
                if (lblIsActive.Text == "True")
                {
                    lblIsActive.Text = "Active";
                    lblIsActive.CssClass = "badge badge-success";
                }
                else
                {
                    lblIsActive.Text = "Inactive";
                    lblIsActive.CssClass = "badge badge-danger";
                }

                if (Convert.ToInt32(lblQuantity.Text) <= 5)
                {
                    lblQuantity.CssClass = "badge badge-danger";
                    lblQuantity.ToolTip = "Item about to be 'Out of stock'!";
                }
            }
        }
    }
}