<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="UserInfo.aspx.cs" Inherits="ArtGallery.UserInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript">
        function ShowImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=imgProfile.ClientID%>').prop('src', e.target.result)
                        .width(160)
                        .height(160);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
    <style>
        .menuTabs {
            position: relative;
            top: 1px;
            left: 10px;
        }

        .tab {
            color: black;
            border: 1px solid #ccc;
            border-bottom: none;
            padding: 0px 10px;
            background-color: #f1f1f1;
        }

        .tabBody {
            border: 1px solid #ccc;
            padding: 20px;
            background-color: white;
        }

        .first {
            height: 30px;
            width: 150px;
        }

        .auto-style1 {
            text-align: center;
        }

        .auto-style2 {
            width: 229px;
        }

        .auto-style3 {
            height: 30px;
            width: 184px;
        }

        .auto-style4 {
            width: 184px;
            height: 24px;
        }

        .auto-style5 {
            font-size: large;
        }

        .auto-style6 {
            font-size: xx-large;
            color: #000000;
        }

        .auto-style8 {
            color: #000000;
        }

        .auto-style9 {
            font-size: medium;
        }

        .auto-style11 {
            width: 303px;
            height: 24px;
        }

        .auto-style12 {
            width: 229px;
            height: 24px;
        }

        .myclass {
            height: 20px;
            position: relative;
            border: 2px solid #cdcdcd;
            border-color: rgba(0, 0, 0, .14);
            background-color: AliceBlue;
            font-size: 14px;
        }

        .auto-style14 {
            width: 303px;
        }

        .auto-style15 {
            width: 892px;
        }

        .auto-style16 {
            font-size: medium;
            color: #FF3300;
        }

        .auto-style18 {
            width: 229px;
            text-align: center;
        }

        .historyGrid tr th {
            background-color: #333333;
            color: white;
        }

        .historyGrid td, .historyGrid tr, .historyGrid th {
            border: 1px solid;
            border-color: black;
        }

        .auto-style19 {
            width: 303px;
            height: 30px;
        }

        .auto-style20 {
            width: 229px;
            text-align: center;
            height: 30px;
        }

        .rbll input[type="radio"] {
            margin-left: 10px;
            margin-right: 1px;
        }

        .bi {
            /*margin-top: 12px;*/
            margin-bottom: 4px;
            border-radius: 3px;
            width: 70px;
            height: 30px;
            padding:3px;
        }
    </style>

    <section class="info" id="info">
        <div class="container">
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <h1 class="heading" style="text-align: left; color: black"><b>user information</b>
            </h1>
            <table style="border: 1px solid #C0C0C0; padding: 20px; width: 900px;">
                <tr>
                    <td class="auto-style15" style="padding-top: 20px;">
                        <div style="float: left; padding-right: 15px; padding-bottom: 15px" class="auto-style1">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                             &nbsp;&nbsp;<asp:Image ID="imgProfile" runat="server" Width="160px" Height="160px" ImageAlign="Middle" Style="border: 1px solid GhostWhite; border-radius: 10px;" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                             <br />
                            &nbsp;<br />
                        </div>

                        <div class="text" style="display: inline; color: #0066FF; font-size: large; font-weight: 600;">
                            <asp:Label ID="lblUsername" runat="server" Text="Label" Title="Unique Username" CssClass="auto-style6"></asp:Label>
                            <br />
                            <strong>
                                <asp:Label ID="lblEmail" runat="server" Text="Label" Title="User Email" CssClass="auto-style8"></asp:Label>
                            </strong>
                            <br />
                        </div>
                        <strong>
                            <asp:Label ID="lblCreatedDate" runat="server" CssClass="auto-style9" Text="Label"></asp:Label>
                            <div style="display: block">
                                <br />
                                <asp:Button ID="btnEditProfile" CssClass="btn" runat="server" Text="Edit Detail" BackColor="#F7B731" onmouseover="this.style.backgroundColor='#ff8243';" onmouseout="this.style.backgroundColor='#F7B731';" OnClick="btnEditProfile_Click" CausesValidation="false" />
                                <br />
                            </div>
                        </strong>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style15">
                        <asp:FileUpload ID="fuProfileImage" runat="server" onchange="ShowImagePreview(this);" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style15">
                        <br />
                        <asp:Menu ID="menuTabs" CssClass="menuTabs" StaticMenuItemStyle-CssClass="tab"
                            Orientation="Horizontal" OnMenuItemClick="menuTabs_MenuItemClick" runat="server" Font-Size="Large" Font-Bold="True" StaticHoverStyle-BackColor="#ff8243" BackColor="#000666" StaticSelectedStyle-BackColor="#F7B731">
                            <Items>
                                <asp:MenuItem Text="Basic Info" Value="0" Selected="true" />
                                <asp:MenuItem Text="Purchased History" Value="1" />
                            </Items>

                            <StaticHoverStyle BackColor="#ff8243"></StaticHoverStyle>

                            <StaticMenuItemStyle CssClass="tab"></StaticMenuItemStyle>

                            <StaticSelectedStyle CssClass="selectedTab" BackColor="#F7B731"></StaticSelectedStyle>
                        </asp:Menu>

                        <div class="tabBody">
                            <asp:MultiView ID="multiTabs" ActiveViewIndex="0" runat="server">
                                <asp:View ID="view1" runat="server">
                                    <table style="font-size: 14px;">
                                        <tr>
                                            <td class="auto-style3">
                                                <h3>Full Name&nbsp;&nbsp;&nbsp; </h3>
                                            </td>
                                            <td class="auto-style14">
                                                <span class="auto-style5">: </span>
                                                <asp:TextBox ID="txtTableFullName" placeholder="E.g. John Lee Xiao Ming" runat="server" CssClass="auto-style5" class="myclass" BorderColor="#666699"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtTableFullName" CssClass="auto-style27" ErrorMessage="Please make sure the name does not contain symbol and numbers." ForeColor="#FF3300" ValidationExpression="(^[a-zA-Z][a-zA-Z\s]{0,20}[a-zA-Z\s]$)">*</asp:RegularExpressionValidator>
                                            </td>
                                            <td class="auto-style18">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style3">
                                                <h3>Password&nbsp;&nbsp; </h3>
                                            </td>
                                            <td class="auto-style14">
                                                <span class="auto-style5">: </span>
                                                <asp:TextBox ID="txtTablePW" runat="server" placeholder="E.g. Abc12345!" CssClass="auto-style5"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtTablePW" CssClass="auto-style27" ErrorMessage="Minimum 8 characters and contains at least 1 alphabet and 1 number." ForeColor="#FF3300" ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$">*</asp:RegularExpressionValidator>
                                            </td>
                                            <td class="auto-style18">
                                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="#FF3300" DisplayMode="List" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style3">
                                                <h3>Mobile No.</h3>
                                            </td>
                                            <td class="auto-style14">
                                                <span class="auto-style5">: </span>
                                                <asp:TextBox ID="txtTablePhoneNumber" placeholder="E.g. 0171212432" runat="server" CssClass="auto-style5"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtTablePhoneNumber" CssClass="auto-style27" ErrorMessage="At least 10/ 11 contact number only" ForeColor="#FF3300" ValidationExpression="^\(?([0-9]{3})\)?[-. ]?([0-9]{4})[-. ]?([0-9]{3,4})$">*</asp:RegularExpressionValidator>
                                            </td>
                                            <td class="auto-style18"><strong>
                                                <asp:Label ID="lblErrorMessage" runat="server" CssClass="auto-style16" Visible="False"></asp:Label>
                                            </strong></td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style3">
                                                <h3>Email Address</h3>
                                            </td>
                                            <td class="auto-style14">
                                                <span class="auto-style5">: </span>
                                                <asp:TextBox ID="txtTableEmailAddress" placeholder="E.g. testing@gmail.com" runat="server" CssClass="auto-style5" TextMode="Email"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtTableEmailAddress" CssClass="auto-style27" ErrorMessage="Do double check the email address format." ForeColor="#FF3300" ValidationExpression="^[a-zA-Z0-9\\w.]+[@]+[a-zA-Z0-9\\w]+[.]+[a-zA-Z0-9\\w]*$">*</asp:RegularExpressionValidator>
                                            </td>
                                            <td class="auto-style18">
                                                <asp:Button ID="btnConfirmUpdate" runat="server" CssClass="btn" OnClick="btnConfirmUpdate_Click" Text="Confirm Update" BackColor="green" ForeColor="White" onmouseover="this.style.backgroundColor='#2ecc71';" onmouseout="this.style.backgroundColor='green';" Visible="False" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style4">
                                                <h3>Address</h3>
                                            </td>
                                            <td class="auto-style11">
                                                <span class="auto-style5">: </span>
                                                <asp:TextBox ID="txtTableAddress" runat="server" placeholder="E.g. 123, Jalan Lucky" CssClass="auto-style5" TextMode="MultiLine" Height="23px" Width="216px"></asp:TextBox>
                                            </td>
                                            <td class="auto-style12">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style3">
                                                <h3>Zip Code</h3>
                                            </td>
                                            <td class="auto-style19">
                                                <span class="auto-style5">: </span>
                                                <asp:TextBox ID="txtTableZipCode" runat="server" placeholder="E.g. 65000" CssClass="auto-style5" MaxLength="5"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="txtTableZipCode" CssClass="auto-style27" ErrorMessage="5 digits zip code only" ForeColor="#FF3300" ValidationExpression="\d{5}">*</asp:RegularExpressionValidator>
                                            </td>
                                            <td class="auto-style20">
                                                <asp:Button ID="btnEditCancel" runat="server" CssClass="btn" BackColor="#F7B731" onmouseover="this.style.backgroundColor='#ff8243';" onmouseout="this.style.backgroundColor='#F7B731';" Text="Cancel" Visible="False" OnClick="btnEditCancel_Click" CausesValidation="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style3">
                                                <h3>Birth Date</h3>
                                            </td>
                                            <td class="auto-style14"><span class="auto-style5">: </span>
                                                <asp:TextBox ID="txtTableDOB" runat="server" CssClass="auto-style5" TextMode="Date" Width="216px"></asp:TextBox>
                                            </td>
                                            <td class="auto-style2">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style3">
                                                <h3>Gender</h3>
                                            </td>
                                            <td class="auto-style14"><span class="auto-style5">:<strong><span class="auto-style8">&nbsp;
                                         <asp:RadioButtonList ID="radUserInfoGender" runat="server" CellPadding="5" CellSpacing="5" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="rbll">
                                             <asp:ListItem>Male</asp:ListItem>
                                             <asp:ListItem>Female</asp:ListItem>
                                         </asp:RadioButtonList>
                                            </span></strong></span></td>
                                            <td class="auto-style2">&nbsp;</td>
                                        </tr>
                                    </table>
                                </asp:View>
                                <asp:View ID="view2" runat="server">
                                    <asp:Repeater ID="rOrder" runat="server" OnItemDataBound="rOrder_ItemDataBound" OnItemCommand="rOrder_ItemCommand">
                                        <ItemTemplate>
                                            <div class="row" style="height:40px">
                                                <div class="col-5" style="background: #cdcdcd; font-family: sans-serif; font-size: 12pt">
                                                    <asp:Label ID="lblNo" runat="server" Text='<%# Eval("#") %>' CssClass="badge badge-pill badge-dark"></asp:Label>
                                                    Order Date:
                                                    <asp:Label ID="lblOrderDate" runat="server" Text='<%# Eval("OrderDate") %>'></asp:Label>
                                                </div>
                                                <div class="col-5" style="background: #cdcdcd; font-family: sans-serif; font-size: 12pt">
                                                    Order No:
                                                    <asp:Label ID="lblOrderNo" runat="server" Text='<%# Eval("OrderNo") %>'></asp:Label>
                                                </div>
                                                <div class="col" align="right" style="padding-top: 8px; background: #cdcdcd; font-family: sans-serif; font-size: 12pt">
                                                    <asp:LinkButton ID="btnInvoice" runat="server" CssClass="bi btn-info" Font-Underline="false"
                                                        CommandArgument='<%# Eval("OrderNo") %>' CommandName="ViewInvoice">
                                                        <i class="fa fa-download"></i>Invoice
                                                    </asp:LinkButton>
                                                </div>
                                            </div>
                                            <asp:Repeater ID="rHistory" runat="server" OnItemDataBound="rHistory_ItemDataBound">
                                                <HeaderTemplate>
                                                    <table class="table table-bordered table-hover" style="width: 99.7%; margin-left: auto; margin-right: auto; font-family: sans-serif; font-size: 11pt">
                                                        <thead class="thead-dark">
                                                            <tr>
                                                                <th scope="col">Artwork Name</th>
                                                                <th scope="col">Unit Price (RM)</th>
                                                                <th scope="col">Qty</th>
                                                                <th scope="col">Total Price (RM)</th>
                                                                <th scope="col">Status</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td><%# Eval("Name") %></td>
                                                        <td><%# Eval("Price") %></td>
                                                        <td><%# Eval("Quantity") %></td>
                                                        <td><%# Eval("TotalPrice") %></td>
                                                        <td>
                                                            <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    </tbody>
                                                    </table>
                                                </FooterTemplate>
                                            </asp:Repeater>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Panel ID="pnState" runat="server" Visible='<%# rOrder.Items.Count == 0 %>'>
                                                <span style="font-size:11pt"><b>Empty. Don't wait and shop now! </b></span>&nbsp;
                                                <asp:LinkButton ID="btnShop" runat="server" Text="Click To Order" CssClass="btn-info btn-lg" PostBackUrl="~/Gallery.aspx" style="text-decoration:none;" />
                                            </asp:Panel>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </asp:View>
                            </asp:MultiView>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </section>
</asp:Content>
