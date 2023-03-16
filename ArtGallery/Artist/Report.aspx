<%@ Page Title="" Language="C#" MasterPageFile="~/Artist/Artist.Master" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="ArtGallery.Artist.Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .btn-extra-format {
            margin-top: 5px;
        }
    </style>
    <script>
        // For disappearing alert message //
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID %>").style.display = "none";
            }, seconds * 1000);
        };
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pcoded-inner-content pt-0" style="min-height: 69.2vh">
        <div class="align-align-self-end">
            <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
        </div>
        <div class="main-body">
            <div class="page-wrapper">
                <div class="page-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-block">
                                    <div class="row">
                                        <div class="col-sm-4" style="padding-right: 10px">
                                            <label>From Date</label><br />
                                            <asp:TextBox ID="txtFromDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-4" style="padding-left: 0">
                                            <label>To Date</label><br />
                                            <asp:TextBox ID="txtToDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <div>
                                            <br />
                                            <asp:Button ID="btnSearch" runat="server" Text="Search"
                                                CssClass="btn btn-primary btn-extra-format" OnClick="btnSearch_Click" />
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 40px">
                                        <div class="col">
                                            <h4 class="sub-title">Selling Report</h4>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">
                                                    <asp:Panel ID="pnReport" runat="server" Visible="false">
                                                        <div class="card-block table-border-style">
                                                            <div class="table-responsive">
                                                                <asp:Repeater ID="rReport" runat="server">
                                                                    <HeaderTemplate>
                                                                        <table class="table data-table-export table-hover nowrap">
                                                                            <thead>
                                                                                <tr>
                                                                                    <th>#</th>
                                                                                    <th>Full Name</th>
                                                                                    <th>Email</th>
                                                                                    <th>Item Orders</th>
                                                                                    <th>Total Cost (RM)</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <tr>
                                                                            <td><%# Eval("#") %></td>
                                                                            <td><%# Eval("Name") %></td>
                                                                            <td><%# Eval("EmailAddress") %></td>
                                                                            <td><%# Eval("ItemOrders") %></td>
                                                                            <td><%# Eval("TotalCost") %></td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                    <FooterTemplate>
                                                                        </tbody>
                                                                        </table>
                                                                    </FooterTemplate>
                                                                </asp:Repeater>
                                                            </div>
                                                            <asp:Label ID="lblAmount" runat="server" Visible="false"></asp:Label>
                                                        </div>
                                                    </asp:Panel>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
