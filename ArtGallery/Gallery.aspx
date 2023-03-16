<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="Gallery.aspx.cs" Inherits="ArtGallery.Gallery" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <style>
        .gallery,
        .gallery::after,
        .gallery::before {
            box-sizing: border-box;
            font-family: sans-serif;
        }
        .gallery .hero-container {
            background: url('https://bit.ly/3Nl69E1') center/cover;
            position: relative;
            height: 45vh;
        }
        .gallery .hero-container::before{
            content: "";
            position: absolute;
            width: 100%;
            height: 100%;
        }
        .gallery .form .hero-body{
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100%;
        }
        .gallery{
            margin: 0;
        }
        .gallery h1 {
            position: relative;
            margin: 0;
            color: white;
            font-size: 28pt;
            margin-bottom: 5px;
            text-align:center;
            font-weight: bold;
        }
        .gallery .form {
            position: relative;
            justify-content: center;
            align-items: center;
            display: flex;
        }
        .gallery .search-area {
            width: 500px;
            padding: 10px;
            border-radius: 4px 0px 0px 4px;
            border: 0;
        }
        .gallery .btn-search {
            padding: 10px;
            border-radius: 0px 4px 4px 0px;
            border: 0;
            cursor: pointer;
        }
        .gallery .btn-search:hover{
            background: #f7b731;
        }
        .art {
            background: #f4f4f4;
        }
        .category-drop-down-style {
            width: 200px;
            padding: 7px;
            font-size: 11pt;
            box-shadow: rgba(0, 0, 0, 0.16) 0px 3px 6px, rgba(0, 0, 0, 0.23) 0px 3px 6px;       
            background-color: #fcf0f4;
            color: #AA4A44;
            font-family: Arial;
        }
        .btn-gallery {
            border-radius:10px;
            padding: 10px;
        }
        .qty-drop-down-style {
            width: 100px;
            padding:5px;
            font-family: Arial;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="gallery">
        <div class="hero-container">
            <div class="hero-body">
                <br />
                <br />
                <br />
                <br />
                <br />
                <br />
                <br />
                <br />
                <h1>Paintings For Sale</h1>
                <div class="form">
                    <asp:TextBox ID="txtSearch" Font-Size="11pt" CssClass="search-area" runat="server" placeholder="Search artworks"></asp:TextBox>
                    <asp:Button ID="btnSearch" Font-Size="11pt" CssClass="btn-search" runat="server" Text="Search" OnClick="btnSearch_Click" />
                </div>
            </div>
        </div>
    </div>
    <section class="art">
        <asp:DropDownList ID="ddlCategory" AutoPostBack="True" 
            CssClass="category-drop-down-style" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" 
            runat="server" DataSourceID="SqlDataSource1" DataTextField="Name" 
            DataValueField="CategoryId" AppendDataBoundItems="true">
            <asp:ListItem Value="0">Filter Category</asp:ListItem>
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cs %>" SelectCommand="SELECT [CategoryId], [Name] FROM [Categories]"></asp:SqlDataSource>
        <br />
        <br />
        <asp:DataList ID="DataList1" runat="server" CellSpacing="20" RepeatColumns="4" RepeatDirection="Horizontal" OnItemCommand="DataList1_ItemCommand" OnItemDataBound="DataList1_ItemDataBound" >
            <ItemTemplate>
                <table style="background:white;width:250px;margin:10px">
                    <tr>
                        <td>
                            <asp:Image ID="imgArtwork" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' 
                                Height="280" Width="250" />
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left:10px;padding-top:10px">
                            <asp:HiddenField ID="hdnArtworkId" runat="server" Value='<%# Eval("ArtworkId") %>' />
                            <asp:Label ID="lblName" runat="server" Font-Size="14pt" Font-Bold="true" Text='<%# Eval("Name") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left:10px; color:green; font-size:12pt; font-weight:bold">
                            RM <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Price") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left:10px;">
                            <asp:Label ID="lblCategory" runat="server" Font-Size="11pt" Text='<%# Eval("CategoryName") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left:10px;">
                            ━ <asp:Label ID="lblArtistName" runat="server" Font-Italic="true" Font-Size="11pt" Text='<%# Eval("ArtistName") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-size:11pt;padding-left:10px">
                            <asp:Label ID="lblStock" runat="server" Text='<%# Eval("Quantity") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left:10px; font-size:11pt">
                            Quantity: <asp:DropDownList ID="ddlQuantity" runat="server" 
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
                        <td align="right" style="padding:10px; font-size:11pt">
                            <asp:Button ID="btnWishlist" CssClass="btn-gallery btn-warning" 
                                runat="server" Text="Wishlist" CommandArgument='<%# Eval("ArtworkId") %>' CommandName="AddToWishlist" />
                            &nbsp;
                            <asp:Button ID="btnCart" CssClass="btn-gallery btn-info" runat="server" 
                                Text="Add To Cart" CommandArgument='<%# Eval("ArtworkId") %>' CommandName="AddToCart"/>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList>
        <br /><br />
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
