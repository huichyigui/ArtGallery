<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="Wishlist.aspx.cs" Inherits="ArtGallery.Wishlist" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .cart {
            min-height: 53vh;
        }
        .wrapper {
            margin: 0 auto;
            width:1000px;
        }
    </style>
<section class="cart" id="cart">
    <br /><br /><br /><br /><br /><br /><br />
    <div class="wrapper" align="center">
        <h1 class="heading" style="color:#333; text-align:left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>Your Wishlist</b></h1>
        <table style="width:1000px">
            <tr>
                <td colspan="2" align="center">
                    <asp:GridView ID="grvWishlist" runat="server" CssClass="table" AutoGenerateColumns="False" Font-Size="Medium" 
                        Width="750px" ShowFooter="True" OnRowDeleting="grvWishlist_RowDeleting" 
                        EmptyDataText="You Wishlist is empty.">
                        <Columns>
                            <asp:BoundField DataField="No" HeaderText="#">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" Width="25px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ArtworkId" HeaderText="Artwork ID" Visible="False" />
                            <asp:BoundField DataField="Name" HeaderText="Artwork Name">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:ImageField DataImageUrlField="ImageUrl" HeaderText="Image">
                                <ControlStyle Height="60px" Width="50px" />
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:ImageField>
                            <asp:BoundField DataField="Price" HeaderText="Unit Price (RM)">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandName="Delete" ImageUrl="~/Images/icons8_multiply_25px_1.png" Text="Delete" OnClientClick="return confirm('Are you sure to delete?');" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td align="left">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button id="btnContinue" CssClass="btn" runat="server" Text="Continue Shopping" BackColor="#2952BE" onmouseover="this.style.backgroundColor='#29b6f6';" onmouseout="this.style.backgroundColor='#2952BE';" PostBackUrl="~/Gallery.aspx" />
                </td>
                <td align="right">
                    <asp:Button id="btnClearWishlist" CssClass="btn" runat="server" Text="Clear Wishlist" BackColor="#f7b731" onmouseover="this.style.backgroundColor='#ffa726';" onmouseout="this.style.backgroundColor='#f7b731';" 
                        OnClientClick="return confirm('Do you want to clear your wishlist?');" OnClick="btnClearWishlist_Click" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
            </tr>
        </table>
    </div>
</section>
</asp:Content>
