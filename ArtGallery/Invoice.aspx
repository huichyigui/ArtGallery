<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="Invoice.aspx.cs" Inherits="ArtGallery.Properties.Invoice" %>
<%@ PreviousPageType VirtualPath="~/Payment.aspx" %>  
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .invoice {
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: center;
            background-image: linear-gradient(rgba(0,0,0,0.4),rgba(0,0,0,0.4)),url('https://bit.ly/36ymF2L');
        }
        .tblInvoice, .tblInvoice th,.tblInvoice tr, .tblInvoice td {
            background: rgba(255, 255, 255, .5); 
            padding:5px;
            width:900px;
            border-collapse:collapse;
            border:1px solid #333333;
            font-size:medium;
            margin-bottom:10px;
        }
        .bis {
            display: inline-block;
            padding: .8rem 3rem;
            font-size: 1.7rem;
            border-radius: .5rem;
            cursor: pointer;
            font-weight: 600;
        }
    </style>
    <section class="invoice" id="invoice">
    <br /><br /><br /><br /><br /><br /><br />
    <div class="wrapper" align="center">
        <h1 class="heading" style="color:#fff; text-align:left;"><b>Your Invoice</b></h1>
        <asp:Panel ID="Panel1" runat="server">
            <table class="tblInvoice">
                <tr>
                    <%-- Order No. & Order Date --%>
                    <td colspan="2">Order No:
                        <asp:Label ID="lblOrderNo" runat="server"></asp:Label>
                        <br /><br />
                        Order Date:
                        <asp:Label ID="lblOrderDate" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <%-- User Address --%>
                    <td style="width:60%">Buyer Address:
                        <br />
                        <asp:Label ID="lblBuyerAddress" runat="server"></asp:Label>
                    </td>
                    <%-- Seller Address --%>
                    <td>
                        Seller Address:
                        <br />
                        26 Jalan Satu, Selayang
                    </td>
                </tr>
                <%-- GridView for displaying Purchased Product --%>
                <tr>
                    <td colspan="2">
                        <asp:GridView ID="grvOrder" runat="server" AutoGenerateColumns="False"
                            Width="1000px">
                            <Columns>
                                <asp:BoundField DataField="ArtworkId" HeaderText="Artwork Id" Visible="False">
                                    <HeaderStyle HorizontalAlign="Left" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Name" HeaderText="  Artwork Name">
                                            
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" />
                                            
                                </asp:BoundField>
                                <asp:BoundField DataField="Price" HeaderText="Unit Price (RM)">
                                    <HeaderStyle HorizontalAlign="Left" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Quantity" HeaderText="Quantity">
                                    <HeaderStyle HorizontalAlign="Left" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="TotalPrice" HeaderText="Net Price (RM)">
                                    <HeaderStyle HorizontalAlign="Left" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                            </Columns>
                            <FooterStyle Height="35px" />
                            <HeaderStyle ForeColor="#333333" Height="25px" BorderColor="#333333" BorderWidth="1px" />
                            <RowStyle BorderColor="#333333" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        Total Artwork: <asp:Label ID="lblCount" runat="server"></asp:Label>
                    </td>
                    <td align="right">
                        Grand Total: <asp:Label ID="lblGrand" runat="server"></asp:Label>
                </tr>
                <%-- PDF Note --%>
                <tr>
                    <td colspan="2" class="text-center">
                        This is a computer generated invoice and does not required signature.
                        <br />
                        <br />
                        <asp:Label ID="lblSentMessage" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Button ID="btnDownload" runat="server" CssClass="bis btn-primary" Text="Download Invoice" BackColor="#2952BE" onmouseover="this.style.backgroundColor='#29b6f6';" onmouseout="this.style.backgroundColor='#2952BE';" OnClick="btnDownload_Click" />&nbsp;&nbsp;
        <asp:Button ID="btnEmail" runat="server" ClientIDMode="Static" CssClass="bis btn-warning" OnClientClick="return confirm('The Invoice will be sent to the email Address Asscociated with your account')" Text="Send To My Email" OnClick="btnEmail_Click"/>
    </div>
</section>
</asp:Content>
