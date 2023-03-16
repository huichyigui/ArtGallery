<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="ArtistDetail.aspx.cs" Inherits="ArtGallery.ArtistDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .artist-work {
            background: #f4f4f4;
            min-height: 90vh;
        }
        .btn-art {
            border-radius:10px;
            padding: 10px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="artist-work" id="artist-work">
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <h1 class="heading" style="color: #333"><b>All artworks by
        <asp:Label ID="lblArtistName" runat="server"></asp:Label></b></h1>
        <asp:DataList ID="DataList1" runat="server" CellSpacing="10" RepeatColumns="4" RepeatDirection="Horizontal" OnItemCommand="DataList1_ItemCommand" OnItemDataBound="DataList1_ItemDataBound">
            <ItemTemplate>
                <table style="background: white;width:250px;margin:10px">
                    <tr>
                        <td>
                            <asp:Image ID="imgArtwork" BorderStyle="None" runat="server" ImageUrl='<%# Eval("ImageUrl") %>'
                                Height="279" Width="250" />
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 10px;padding-top:10px">
                            <asp:HiddenField ID="hdnArtworkId" runat="server" Value='<%# Eval("ArtworkId") %>' />
                            <asp:Label ID="lblName" runat="server" Font-Size="14pt" Font-Bold="true" Text='<%# Eval("Name") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 10px; color: green; font-size: 12pt; font-weight: bold">RM
                                <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Price") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 10px;">
                            <asp:Label ID="lblCategory" runat="server" Font-Size="11pt" Text='<%# Eval("CategoryName") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 10px;">━
                                <asp:Label ID="lblArtistName" runat="server" Font-Italic="true" Font-Size="11pt" Text='<%# Eval("ArtistName") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-size: 11pt; padding-left: 10px">
                                <asp:Label ID="lblStock" runat="server" Text='<%# Eval("Quantity") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 10px; font-size: 11pt">Quantity:
                                <asp:DropDownList ID="ddlQuantity" runat="server"
                                    CssClass="qty-drop-down-style">
                                    <asp:ListItem>1</asp:ListItem>
                                    <asp:ListItem>2</asp:ListItem>
                                    <asp:ListItem>3</asp:ListItem>
                                    <asp:ListItem>4</asp:ListItem>
                                    <asp:ListItem>5</asp:ListItem>
                                </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="padding: 10px; font-size: 11pt">
                            <asp:Button ID="btnWishlist" CssClass="btn-art btn-warning"
                                runat="server" Text="Wishlist" CommandArgument='<%# Eval("ArtworkId") %>' CommandName="AddToWishlist" />
                            &nbsp;
                            <asp:Button ID="btnCart" CssClass="btn-art btn-info" runat="server"
                                Text="Add To Cart" CommandArgument='<%# Eval("ArtworkId") %>' CommandName="AddToCart" />
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList>
        <br />
        <div align="center">
            <h2 style="text-align: center">
                <asp:Label ID="lblName" runat="server"></asp:Label>
                <asp:Label ID="lblMessage" runat="server" Text=" does not post any artworks yet."></asp:Label></h2>
            <br />
            <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/comesoon.png" Height="252px" Width="427px" />
        </div>
        <table id="tblPaging" style="font-size: 18px;margin-left:auto; margin-right:auto">
            <tr>
                <td style="padding-right: 7px" valign="top">
                    <asp:LinkButton ID="lnkbtnPrevious" runat="server" OnClick="lnkbtnPrevious_Click">Previous</asp:LinkButton>
                </td>
                <td valign="top">
                    <asp:DataList ID="dlPaging" runat="server" OnItemCommand="dlPaging_ItemCommand" OnItemDataBound="dlPaging_ItemDataBound" RepeatDirection="Horizontal">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkbtnPaging" runat="server" CommandArgument='<%# Eval("PageIndex") %>'
                                CommandName="lnkbtnPaging" Text='<%# Eval("PageText") %>' Width="30"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:DataList>
                </td>
                <td style="padding-left: 7px" valign="top">
                    <asp:LinkButton ID="lnkbtnNext" runat="server" OnClick="lnkbtnNext_Click">Next</asp:LinkButton>
                </td>
            </tr>
        </table>
    </section>
</asp:Content>
