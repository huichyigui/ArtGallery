<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="ArtGallery.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .cart {
            min-height: 53vh;
        }

        .wrapper {
            margin: 0 auto;
            width: 1000px;
        }
    </style>
    <section class="cart" id="cart">
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <div class="wrapper">
            <h1 class="heading" style="color: #333; text-align: left;"><b>Your Shopping Cart</b></h1>

            <table>
                <tr>
                    <td colspan="3">
                        <asp:GridView ID="grvCart" runat="server" CssClass="table" align="center" AutoGenerateColumns="False" EmptyDataText="Your Cart is empty." ShowFooter="True" Font-Size="Medium" Width="943px" 
                            OnRowDeleting="grvCart_RowDeleting">
                            <columns>
                                <asp:BoundField DataField="No" HeaderText="#">
                                    <headerstyle horizontalalign="Left" />
                                    <itemstyle horizontalalign="Left" width="25px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ArtworkId" HeaderText="Artwork ID" Visible="False" />
                                <asp:BoundField DataField="Name" HeaderText="Artwork Name">
                                    <headerstyle horizontalalign="Left" />
                                    <itemstyle horizontalalign="Left" />
                                </asp:BoundField>
                                <asp:ImageField DataImageUrlField="ImageUrl" HeaderText="Image">
                                    <controlstyle height="60px" width="50px" />
                                    <headerstyle horizontalalign="Left" />
                                    <itemstyle horizontalalign="Left" />
                                </asp:ImageField>
                                <asp:BoundField DataField="Price" HeaderText="Unit Price (RM)">
                                    <headerstyle horizontalalign="Left" />
                                    <itemstyle horizontalalign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Quantity" HeaderText="Quantity">
                                    <headerstyle horizontalalign="Left" />
                                    <itemstyle horizontalalign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="TotalPrice" HeaderText="Net Price (RM)" DataFormatString="{0:N2}">
                                    <headerstyle horizontalalign="Left" />
                                    <itemstyle horizontalalign="Left" />
                                </asp:BoundField>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandName="Delete" ImageUrl="~/Images/icons8_multiply_25px_1.png" Text="Delete" OnClientClick="return confirm('Are you sure to delete?');"/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td style="width: 333px">
                        <asp:Button id="btnContinue" CssClass="btn" runat="server" Text="Continue Shopping" BackColor="#2952BE" onmouseover="this.style.backgroundColor='#29b6f6';" onmouseout="this.style.backgroundColor='#2952BE';" PostBackUrl="~/Gallery.aspx" />
                    </td>
                    <td align="center" style="width: 500px">
                        <asp:Button id="btnClearCart" CssClass="btn" runat="server" Text="Clear Cart" BackColor="#f7b731" onmouseover="this.style.backgroundColor='#ffa726';" onmouseout="this.style.backgroundColor='#f7b731';" 
                            OnClientClick="return confirm('Do you want to clear your cart?');" OnClick="btnClearCart_Click" />
                    </td>
                    <td align="right" style="width: 333px">
                        <asp:Button id="btnCheckout" CssClass="btn" runat="server" Text="Checkout" BackColor="#009933" onmouseover="this.style.backgroundColor='#2ecc71';" onmouseout="this.style.backgroundColor='#009933';" OnClick="btnCheckout_Click" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                </tr>
            </table>
        </div>
    </section>
</asp:Content>
