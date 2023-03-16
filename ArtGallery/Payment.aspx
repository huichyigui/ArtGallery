<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="ArtGallery.Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
    <style>
        .payment {
            font-size: 12pt;
            min-height: 100vh;
            /*background: #f5f5f5;*/
            background: linear-gradient(rgba(0,0,0,0.4),rgba(0,0,0,0.4)),url('https://c4.wallpaperflare.com/wallpaper/156/214/373/background-banking-banknote-bill-wallpaper-preview.jpg');
            background-position: center;
            background-size: cover;
            background-attachment: fixed;
        }

        .payment .rounded-lg {
            border-radius: 1rem;
        }

        .payment .nav-pills .nav-link {
            color: #555;
        }

        .payment .nav-pills .nav-link.active {
            color: #fff;
        }

        .btn-payment {
            display: inline-block;
            padding: .8rem 3rem;
            font-size: 1.7rem;
            cursor: pointer;
            font-weight: 600;
            border-radius: .5rem;
        }
        .title {
            font-weight: bold;
            text-align: center;
            color: #fff;
            text-transform: uppercase;
            font-size: 4rem;
        }
        .b {
            margin-bottom : 10px;
        }
    </style>
    <script type="text/javascript">
        function EnableDisableCheckBox() {
            if (document.getElementById("<%=chkAddress1.ClientID %>").checked) {
                var txtAddress = document.getElementById("<%= txtAddress1.ClientID %>");
                txtAddress.disabled = !this.checked;
            } 
            else {
                document.getElementById('<%=txtAddress1.ClientID%>').disabled = false;
            }

            if (document.getElementById("<%=chkAddress2.ClientID %>").checked) {
                var txtAddress = document.getElementById("<%= txtAddress2.ClientID %>");
                txtAddress.disabled = !this.checked;
            }
            else {
                document.getElementById('<%=txtAddress2.ClientID%>').disabled = false;
            }
        }
    </script>
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
    <section class="payment">
        <br />
        <br />
        <br />
        <br />
        <h1 class="title">Order Payment</h1>
        <div class="container py-5">
            <div class="row">
                <div class="col-lg-7 mx-auto">
                    <div class="bg-white rounded-lg shadow-sm p-5">
                        <!-- Credit card form tabs -->
                        <ul role="tablist" class="nav bg-light nav-pills rounded-pill nav-fill mb-3">
                            <li class="nav-item">
                                <a data-toggle="pill" href="#nav-tab-card" class="nav-link active rounded-pill">
                                    <i class="fa fa-credit-card"></i>
                                    Credit Card
                                </a>
                            </li>
                            <li class="nav-item">
                                <a data-toggle="pill" href="#nav-tab-cod" class="nav-link rounded-pill">
                                    <i class="fa fa-money-bill"></i>
                                    Cash On Delivery
                                </a>
                            </li>
                        </ul>
                        <!-- End -->
                        <!-- Credit card form content -->
                        <div class="tab-content">
                            <!-- credit card info-->
                            <div id="nav-tab-card" class="tab-pane fade show active">
                                <asp:Label ID="lblMsg" runat="server" visible="false"></asp:Label>
                                <form role="form">
                                    <div class="form-group">
                                        <label for="cardHolder">Card Holder</label>
                                        <asp:TextBox ID="txtCardHolder" Font-Size="11pt" class="form-control" placeholder="Card Holder Name" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                            ErrorMessage="Card Holder Name is Required" ForeColor="Red" 
                                            ControlToValidate="txtCardHolder" Display="Dynamic" ValidationGroup="cc"
                                            SetFocusOnError="True">
                                        </asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="cardNumber">Card Number</label>
                                        <div class="input-group">
                                            <asp:TextBox ID="txtCardNumber" Font-Size="11pt" runat="server" placeholder="16-Digit Card Number"
                                                class="form-control"></asp:TextBox>
                                            <div class="input-group-append">
                                                <span class="input-group-text text-muted">
                                                    <i class="fa fa-cc-visa mx-1"></i>
                                                    <i class="fa fa-cc-amex mx-1"></i>
                                                    <i class="fa fa-cc-mastercard mx-1"></i>
                                                </span>
                                            </div>
                                        </div>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                            ErrorMessage="Card Number is Required" ForeColor="Red"
                                            ControlToValidate="txtCardNumber" Display="Dynamic" ValidationGroup="cc">
                                        </asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                                            ControlToValidate="txtCardNumber" ErrorMessage="Card Number must be of 16 digits" 
                                            ForeColor="Red" ValidationExpression="[0-9]{16}" Display="Dynamic" ValidationGroup="cc">
                                        </asp:RegularExpressionValidator>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-8">
                                            <div class="form-group">
                                                <label><span class="hidden-xs">Expiry Date</span></label>
                                                <div class="input-group">
                                                    <asp:DropDownList ID="ddlMonth" Font-Size="11pt" runat="server" class="form-control">
                                                        <asp:ListItem>01</asp:ListItem>
                                                        <asp:ListItem>02</asp:ListItem>
                                                        <asp:ListItem>03</asp:ListItem>
                                                        <asp:ListItem>04</asp:ListItem>
                                                        <asp:ListItem>05</asp:ListItem>
                                                        <asp:ListItem>06</asp:ListItem>
                                                        <asp:ListItem>07</asp:ListItem>
                                                        <asp:ListItem>08</asp:ListItem>
                                                        <asp:ListItem>09</asp:ListItem>
                                                        <asp:ListItem>10</asp:ListItem>
                                                        <asp:ListItem>11</asp:ListItem>
                                                        <asp:ListItem>12</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:DropDownList ID="ddlYear" Font-Size="11pt" runat="server" class="form-control">
                                                        <asp:ListItem>2022</asp:ListItem>
                                                        <asp:ListItem>2023</asp:ListItem>
                                                        <asp:ListItem>2024</asp:ListItem>
                                                        <asp:ListItem>2025</asp:ListItem>
                                                        <asp:ListItem>2026</asp:ListItem>
                                                        <asp:ListItem>2027</asp:ListItem>
                                                        <asp:ListItem>2028</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="form-group mb-4">
                                                <label data-toggle="tooltip"
                                                    title="Three-digits code on the back of your card">
                                                    CVV
                                                <i class="fa fa-question-circle"></i>
                                                </label>
                                                <asp:TextBox ID="txtCvv" Font-Size="11pt" runat="server" placeholder="CVV No." class="form-control" MaxLength="3"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                                    ErrorMessage="CVV No. is Required" ForeColor="Red"
                                                    ControlToValidate="txtCvv" Display="Dynamic" ValidationGroup="cc"
                                                    SetFocusOnError="True">
                                                </asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
                                                    ControlToValidate="txtCVV" ErrorMessage="CVV No. must be of 3 digits" 
                                                    ForeColor="Red" ValidationExpression="[0-9]{3}" Display="Dynamic" ValidationGroup="cc">
                                                </asp:RegularExpressionValidator>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="address">Delivery Address</label>
                                        <asp:TextBox ID="txtAddress1" Font-Size="11pt" runat="server" placeholder="Delivery Address" TextMode="MultiLine" class="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                                            ErrorMessage="Delivery Address is required" ForeColor="Red"
                                            Display="Dynamic" ControlToValidate="txtAddress1" ValidationGroup="addressCC"></asp:RequiredFieldValidator><br />
                                        <asp:CheckBox ID="chkAddress1" runat="server" Text="&nbsp; Same as Billing Address" onclick="EnableDisableCheckBox()"/>
                                    </div>
                                    <hr>
                                    <asp:Button ID="btnConfirmPayment" ValidationGroup="cc" 
                                        class="subscribe btn-payment btn-info btn-block shadow-sm" 
                                        runat="server" Text="Confirm Payment" OnClick="btnConfirmPayment_Click" />
                                    <hr />
                                    <p class="badge badge-success">Order Total: <asp:Label ID="lblTotal1" runat="server"></asp:Label></p>
                                    <hr />
                                    <asp:LinkButton ID="btnCart1" runat="server" CausesValidation="false" PostBackUrl="~/Cart.aspx">Back To Shopping Cart</asp:LinkButton>
                                </form>
                            </div>
                            <!-- End -->

                            <!-- COD info -->
                            <div id="nav-tab-cod" class="tab-pane fade">
                                <div class="form-group">
                                    <label for="address">Delivery Address</label>
                                    <asp:TextBox ID="txtAddress2" Font-Size="11pt" runat="server" placeholder="Delivery Address" TextMode="MultiLine" class="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                        ErrorMessage="Delivery Address is required" ForeColor="Red" 
                                        Display="Dynamic" ControlToValidate="txtAddress2" ValidationGroup="addressCOD"></asp:RequiredFieldValidator><br />
                                    <asp:CheckBox ID="chkAddress2" runat="server" Text="&nbsp; Same as Billing Address" onclick="EnableDisableCheckBox()" />
                                </div>
                                <asp:Button ID="btnConfirmOrder" runat="server" Text="Confirm Order" 
                                        class="b btn-payment btn-info"
                                        OnClick="btnConfirmOrder_Click"/><br />
                                <p class="text-muted" style="text-align:justify">
                                    Note: At the time of receiving your order, you need to do full payment.
                                After completing the payment process, you can check your updated order status via our website.
                                </p>
                                <hr />
                                <p class="badge badge-success">Order Total: <asp:Label ID="lblTotal2" runat="server"></asp:Label></p>
                                <hr />
                                <asp:LinkButton ID="btnCart2" runat="server" CausesValidation="false" PostBackUrl="~/Cart.aspx">Back To Shopping Cart</asp:LinkButton>
                            </div>
                            <!-- End -->
                        </div>
                        <!-- End -->
                    </div>
                </div>
            </div>
        </div>
        <script>
            $(function () {
                $('[data-toggle="tooltip"]').tooltip()
            })
        </script>
    </section>
</asp:Content>
