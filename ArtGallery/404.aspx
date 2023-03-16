<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="404.aspx.cs" Inherits="ArtGallery._404" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
        .four-0-four-image {
            display: block;
            margin: 60px auto;
        }
        .four-0-four-msg {
            font-size:13pt;
            text-align: center;
            text-transform: capitalize;
            color: #383838;
        }
        .four-0-four-msg a {
            color: #383838;
        }
        .four-0-four-msg a:hover {
            color: mediumblue;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section style="background:#fff; margin-top: 50px">
        <asp:Image ID="Image1" runat="server" CssClass="four-0-four-image" ImageUrl="~/Images/404.png"></asp:Image>
        <p class="four-0-four-msg">Look like you are lost. Head to back to our <asp:HyperLink ID="hypHome" runat="server" font-underline="true" NavigateUrl="~/Default.aspx">homepage</asp:HyperLink></p>
    </section>
</asp:Content>
