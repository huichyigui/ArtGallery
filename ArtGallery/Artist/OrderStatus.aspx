<%@ Page Title="" Language="C#" MasterPageFile="~/Artist/Artist.Master" AutoEventWireup="true" CodeBehind="OrderStatus.aspx.cs" Inherits="ArtGallery.Artist.OrderStatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        // For disappearing alert message //
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID %>").style.display = "none";
            }, seconds * 1000);
        };
    </script>
    <script>
        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=imgArtwork.ClientID%>').prop('src', e.target.result)
                        .width(200)
                        .height(200);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pcoded-inner-content pt-0" style="min-height:69.3vh">
        <div class="align-align-self-end">
            <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
        </div>
        <div class="main-body">
            <div class="page-wrapper">
                <div class="page-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-header">
                                </div>
                                <div class="card-block">
                                    <div class="row">
                                        <div class="col-sm-6 col-md-8 col-lg-7 mobile-inputs">
                                            <h4 class="sub-title">Order Lists</h4>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">
                                                    <asp:Repeater ID="rOrderList" runat="server" OnItemCommand="rOrderList_ItemCommand"
                                                        OnItemDataBound="rOrderList_ItemDataBound">
                                                        <HeaderTemplate>
                                                            <table class="table data-table-export table-hover nowrap">
                                                                <thead>
                                                                    <tr>
                                                                        <th class="table-plus">Order No.</th>
                                                                        <th>Order Date</th>
                                                                        <th>Status</th>
                                                                        <th>Artwork Name</th>
                                                                        <th>Total Price (RM)</th>
                                                                        <th class="datatable-nosort">Edit</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td class="table-plus"><%# Eval("OrderNo") %> </td>
                                                                <td><%# Eval("OrderDate") %> </td>
                                                                <td>
                                                                    <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                                                </td>
                                                                <td><%# Eval("ArtworkName") %></td>
                                                                <td><%# Eval("TotalPrice") %></td>
                                                                <td>
                                                                    <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CssClass="badge badge-primary"
                                                                        CommandArgument='<%# Eval("OrderDetailsId") %>' CommandName="edit">
                                                                        <i class="ti-pencil"></i>
                                                                    </asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            </tbody>
                                                            </table>
                                                        </FooterTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </div>
                                        </div>
                                        <asp:Panel ID="pnUpdateStatus" runat="server" Visible="false">
                                            <div class="col-sm-12 col-md-12 col-lg-12">
                                                <h4 class="sub-title">Update Status</h4>
                                                <div>
                                                    <div class="form-group">
                                                        <label><b>Order No.</b></label><br />
                                                        <asp:Label ID="lblOrderNo" runat="server"></asp:Label>
                                                        <asp:HiddenField ID="hdnOrderDetailsId" runat="server" Value=0 />
                                                    </div>
                                                    <div class="form-group">
                                                        <label><b>Order Date</b></label><br />
                                                        <asp:Label ID="lblOrderDate" runat="server"></asp:Label>
                                                    </div>
                                                    <div class="form-group">
                                                        <label><b>Artwork Name</b></label><br />
                                                        <asp:Label ID="lblArtworkName" runat="server"></asp:Label>
                                                    </div>
                                                    <div class="form-group">
                                                        <label><b>Artwork Image</b></label><br />
                                                        <asp:Image ID="imgArtwork" runat="server" CssClass="img-thumbnail" />
                                                    </div>
                                                    <div class="form-group">
                                                        <label><b>Order Status</b></label>
                                                        <div>
                                                            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                                                                <asp:ListItem>Pending</asp:ListItem>
                                                                <asp:ListItem>Dispatched</asp:ListItem>
                                                                <asp:ListItem>Delivered</asp:ListItem>
                                                            </asp:DropDownList>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                                                                ErrorMessage="Status is required" ForeColor="Red" Display="Dynamic"
                                                                SetFocusOnError="true" ControlToValidate="ddlStatus">
                                                            </asp:RequiredFieldValidator>
                                                        </div>
                                                    </div>
                                                    <div class="pb-5">
                                                        <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-primary"
                                                            OnClick="btnUpdate_Click" />
                                                        &nbsp;
                                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-primary"
                                                            CausesValidation="false" OnClick="btnCancel_Click" />
                                                    </div>
                                                </div>
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
</asp:Content>
