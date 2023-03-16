<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="Artists.aspx.cs" Inherits="ArtGallery.Artists" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .artist,
        .artist::after,
        .artist::before {
            box-sizing: border-box;
            font-family: sans-serif;
        }

        .artist .hero-container {
            background: url('https://bit.ly/3Lk2AMe') center/cover;
            position: relative;
            height: 45vh;
        }

        .artist .hero-container::before {
            content: "";
            position: absolute;
            background: #000000;
            width: 100%;
            height: 100%;
            opacity:0.4;
        }

        .artist .form .hero-body {
             position: relative;
             display: flex;
             flex-direction: column;
             justify-content: center;
             align-items: center;
             height: 100%;
        }

        .artist {
            margin: 0;
        }
        .artist h1 {
            position: relative;
            margin: 0;
            color: white;
            font-size: 28pt;
            margin-bottom: 5px;
            text-align: center;
            font-weight: bold;
        }
        
        .artist .form {
            position: relative;
            justify-content: center;
            align-items: center;
            display: flex;
        }
        
        .artist .search-area {
            width: 500px;
            padding: 10px;
            border-radius: 4px 0px 0px 4px;
            border: 0;
        }

        .artist .btn-search {
                padding: 10px;
                border-radius: 0px 4px 4px 0px;
                border: 0;
                cursor: pointer;
        }
        
        .artist .btn-search:hover {
            background: #f7b731;
        }

        .artists {
            background: #f4f4f4;
        }

        .circle {
            border-radius:50%;
        }
        .circle:hover {
            filter: sepia(65%) hue-rotate(30deg);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="artist">
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
                <h1>Our Artists</h1>
                <div class="form">
                    <asp:TextBox ID="txtSearch" Font-Size="11pt" CssClass="search-area" runat="server" placeholder="Search artworks"></asp:TextBox>
                    <asp:Button ID="btnSearch" Font-Size="11pt" CssClass="btn-search" runat="server" Text="Search" OnClick="btnSearch_Click" />
                </div>
            </div>
        </div>
    </div>
    <section class="artists">
        <asp:DataList ID="DataList1" runat="server" RepeatColumns="4" RepeatDirection="Horizontal" OnItemCommand="DataList1_ItemCommand" CellSpacing="20">
            <ItemTemplate>
                <table style="margin:10px">
                    <tr>
                        <td>
                            <asp:ImageButton ID="imgArtist" runat="server" CssClass="circle" Width="250" Height="250" ImageUrl='<%# Eval("ImageUrl") %>' CommandName="ViewArtistDetail" CommandArgument='<%# Eval("Username") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <asp:Label ID="lblArtistName" runat="server" Text='<%# Eval("Name") %>' Font-Bold="true" Font-Size="19px"></asp:Label>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList>
        <br /><br />
        <table id="tblPaging" style="font-size: 18px; margin-left:auto; margin-right:auto">
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
