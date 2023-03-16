<%@ Page Title="" Language="C#" MasterPageFile="~/Artist/Artist.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="ArtGallery.Artist.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pcoded-inner-content">
        <div class="main-body">
            <div class="page-wrapper">

                <div class="page-body">
                    <div class="row">
                        <!-- card1 start -->
                        <div class="col-md-6 col-xl-3">
                            <div class="card widget-card-1">
                                <div class="card-block-small">
                                    <i class="icofont icofont-ui-image bg-c-blue card1-icon"></i>
                                    <span class="text-c-blue f-w-600">Artworks</span>
                                    <h4>
                                        <asp:Label ID="lblCountArt" runat="server"></asp:Label>
                                    </h4>
                                    <div>
                                        <span class="f-left m-t-10 text-muted">
                                            <a href="Artwork.aspx"><i class="text-c-blue f-16 icofont icofont-eye-alt m-r-10"></i>View Details</a>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- card1 end -->
                        <!-- card1 start -->
                        <div class="col-md-6 col-xl-3">
                            <div class="card widget-card-1">
                                <div class="card-block-small">
                                    <i class="icofont icofont-file-document bg-c-pink card1-icon"></i>
                                    <span class="text-c-pink f-w-600">Total Orders</span>
                                    <h4>
                                        <asp:Label ID="lblCountOrder" runat="server"></asp:Label>
                                    </h4>
                                    <div>
                                        <span class="f-left m-t-10 text-muted">
                                            <a href="OrderStatus.aspx"><i class="text-c-pink f-16 icofont icofont-eye-alt m-r-10"></i>View Details</a>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- card1 end -->
                        <!-- card1 start -->
                        <div class="col-md-6 col-xl-3">
                            <div class="card widget-card-1">
                                <div class="card-block-small">
                                    <i class="icofont icofont-delivery-time bg-c-green card1-icon"></i>
                                    <span class="text-c-green f-w-600">Pending Items</span>
                                    <h4>
                                        <asp:Label ID="lblCountPend" runat="server"></asp:Label>
                                    </h4>
                                    <div>
                                        <span class="f-left m-t-10 text-muted">
                                            <a href="OrderStatus.aspx"><i class="text-c-green f-16 icofont icofont-eye-alt m-r-10"></i>View Details</a>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- card1 end -->
                        <!-- card1 start -->
                        <div class="col-md-6 col-xl-3">
                            <div class="card widget-card-1">
                                <div class="card-block-small">
                                    <i class="icofont icofont-truck bg-c-blue card1-icon"></i>
                                    <span class="text-c-blue f-w-600">Dispatch Items</span>
                                    <h4>
                                        <asp:Label ID="lblCountDispatch" runat="server"></asp:Label>
                                    </h4>
                                    <div>
                                        <span class="f-left m-t-10 text-muted">
                                            <a href="OrderStatus.aspx"><i class="text-c-blue f-16 icofont icofont-eye-alt m-r-10"></i>View Details</a>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- card1 end -->
                        <!-- card1 start -->
                        <div class="col-md-6 col-xl-3">
                            <div class="card widget-card-1">
                                <div class="card-block-small">
                                    <i class="icofont icofont-truck-alt bg-c-yellow card1-icon"></i>
                                    <span class="text-c-yellow f-w-600">Delivered Items</span>
                                    <h4>
                                        <asp:Label ID="lblCountDeliver" runat="server"></asp:Label>
                                    </h4>
                                    <div>
                                        <span class="f-left m-t-10 text-muted">
                                            <a href="OrderStatus.aspx"><i class="text-c-yellow f-16 icofont icofont-eye-alt m-r-10"></i>View Details</a>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- card1 end -->
                        <!-- card1 start -->
                        <div class="col-md-6 col-xl-3">
                            <div class="card widget-card-1">
                                <div class="card-block-small">
                                    <i class="icofont icofont-money-bag bg-c-orenge card1-icon"></i>
                                    <span class="text-c-orenge f-w-600">Sold Amount</span>
                                    <h4>
                                        <asp:Label ID="lblSoldAmount" runat="server"></asp:Label></h4>
                                    <div>
                                        <span class="f-left m-t-10 text-muted">
                                            <a href="Report.aspx"><i class="text-c-orenge f-16 icofont icofont-eye-alt m-r-10"></i>View Details</a>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- card1 end -->
                    </div>
                    <div id="styleSelector">
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
