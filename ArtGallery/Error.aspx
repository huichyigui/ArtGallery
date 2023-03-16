<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="ArtGallery.Error" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .err-image {
            display: block;
            margin: 0 auto;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section style="background:#fff; margin-top: 50px">
        <asp:Image ID="Image1" runat="server" CssClass="err-image" ImageUrl="~/Images/err.png"></asp:Image>
    </section>
</asp:Content>
