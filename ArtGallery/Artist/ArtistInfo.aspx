<%@ Page Title="" Language="C#" MasterPageFile="~/Artist/Artist.Master" AutoEventWireup="true" CodeBehind="ArtistInfo.aspx.cs" Inherits="ArtGallery.Artist.ArtistInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
        .padding-top {
            padding-top: 20px;
        }

        .first {
            height: 30px;
            width: 150px;
        }

        .artist-info tr, .artist-info td {
            padding-left: 15px;
        }

            .artist-info td h4 {
                font-weight: bold;
            }

        .auto-style1 {
            width: 231px;
        }

        .auto-style2 {
            width: 231px;
            height: 30px;
        }

        .auto-style3 {
            color: #000000;
        }

        .auto-style4 {
            color: #000000;
            font-size: xx-large;
        }

        .auto-style6 {
            height: 30px;
            width: 151px;
        }

        .auto-style7 {
            width: 183px;
            height: 30px;
            font-weight: bold;
        }

        .auto-style8 {
            width: 183px;
            font-weight: bold;
        }

        .auto-style10 {
            width: 277px;
            height: 30px;
        }

        .auto-style12 {
            width: 998px;
        }

        .auto-style13 {
            width: 822px;
        }

        .auto-style14 {
            text-align: center;
            float: left;
            width: 209px;
            height: 189px;
        }

        .auto-style15 {
            margin-left: 0px;
        }

        .auto-style16 {
            font-size: medium;
            color: #FF3300;
        }

        .auto-style17 {
            width: 277px;
        }

        .auto-style19 {
            width: 183px;
            height: 19px;
            font-weight: bold;
        }

        .auto-style20 {
            width: 277px;
            height: 19px;
        }

        .auto-style21 {
            width: 231px;
            height: 19px;
        }

        body {
            text-transform: none;
        }

        .auto-style22 {
            width: 231px;
            text-align: center;
        }

        .rbll input[type="radio"] {
            margin-left: 10px;
            margin-right: 1px;
        }
    </style>
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
    <div class="pcoded-inner-content pt-0">
        <br />
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
                                    <div style="padding-left: 25px">
                                        <h4><strong>ARTIST INFORMATION</strong></h4>
                                        <hr />
                                        <table style="border: 1px solid #C0C0C0; padding: 20px;" class="auto-style13">
                                            <tr>
                                                <td class="auto-style12">
                                                    <div style="padding: 15px" class="auto-style14">
                                                        <asp:Image ID="imgProfile" runat="server" Width="160px" Height="160px" ImageAlign="Middle" Style="border: 1px solid GhostWhite; border-radius: 10px;" />
                                                        &nbsp;<div class="text-center">
                                                            <asp:FileUpload ID="fuProfileImage" runat="server" Visible="False" onchange="ShowImagePreview(this);" />
                                                        </div>
                                                    </div>
                                                    <div class="text" style="display: inline; color: #0066FF; font-size: large; font-weight: 600;">
                                                        <span style="font-size: x-large; font-weight: bold;">
                                                            <br />
                                                            <asp:Label ID="lblArtistUserName" runat="server" Text="Label" CssClass="auto-style4"></asp:Label>
                                                        </span>
                                                        <br />
                                                        <asp:Label ID="lblArtistEmail" runat="server" Text="Label" Title="Unique Username" CssClass="auto-style3"></asp:Label>
                                                        <br />
                                                        <asp:Label ID="lblArtistCreatedDate" runat="server" CssClass="auto-style6" Style="color: #000000; font-size: medium" Text="Label" Title="Unique Username"></asp:Label>
                                                        <br />
                                                        <asp:Button ID="btnArtistEditProfile" CssClass="btn" runat="server" Text="Edit Detail" BackColor="#F7B731" onmouseover="this.style.backgroundColor='#ff8243';" onmouseout="this.style.backgroundColor='#F7B731';" OnClick="btnArtistEditProfile_Click" CausesValidation="false" />
                                                        <br />
                                                    </div>
                                                    <br />
                                                    <hr class="auto-style15" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style12">
                                                    <table class="artist-info">
                                                        <tr>
                                                            <td class="auto-style19">
                                                                <h6>Full Name</h6>
                                                            </td>
                                                            <td class="auto-style20">:
                                    <asp:TextBox ID="txtArtistFullName" runat="server" Font-Names="Arial"></asp:TextBox>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtArtistFullName" CssClass="auto-style27" ErrorMessage="Please make sure the name does not contain symbol and numbers." ForeColor="#FF3300" ValidationExpression="(^[a-zA-Z][a-zA-Z\s]{0,20}[a-zA-Z\s]$)">*</asp:RegularExpressionValidator>
                                                            </td>
                                                            <td class="auto-style21"></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="auto-style7">
                                                                <h6>Password</h6>
                                                            </td>
                                                            <td class="auto-style17">:
                                    <asp:TextBox ID="txtArtistPW" runat="server" Font-Names="Arial"></asp:TextBox>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtArtistPW" CssClass="auto-style27" ErrorMessage="Minimum 8 characters and contains at least 1 alphabet and 1 number." ForeColor="#FF3300" ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$">*</asp:RegularExpressionValidator>
                                                            </td>
                                                            <td class="auto-style1">
                                                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="#FF3300" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="auto-style7">
                                                                <h6>Mobile No.</h6>
                                                            </td>
                                                            <td class="auto-style10">:
                                    <asp:TextBox ID="txtArtistPhoneNumber" runat="server" Font-Names="Arial"></asp:TextBox>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtArtistPhoneNumber" CssClass="auto-style27" ErrorMessage="At least 10/ 11 contact number only" ForeColor="#FF3300" ValidationExpression="^\(?([0-9]{3})\)?[-. ]?([0-9]{4})[-. ]?([0-9]{3,4})$">*</asp:RegularExpressionValidator>
                                                            </td>
                                                            <td class="auto-style2">
                                                                <strong>
                                                                    <asp:Label ID="lblArtistErrorMessage" runat="server" CssClass="auto-style16"></asp:Label>
                                                                </strong>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="auto-style7">
                                                                <h6>Email Address</h6>
                                                            </td>
                                                            <td class="auto-style17">:
                                    <asp:TextBox ID="txtArtistEmailAddress" runat="server" TextMode="Email" Font-Names="Arial"></asp:TextBox>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtArtistEmailAddress" CssClass="auto-style27" ErrorMessage="Do double check the email address format." ForeColor="#FF3300" ValidationExpression="^[a-zA-Z0-9\\w.]+[@]+[a-zA-Z0-9\\w]+[.]+[a-zA-Z0-9\\w]*$">*</asp:RegularExpressionValidator>
                                                            </td>
                                                            <td class="auto-style22">
                                                                <asp:Button ID="btnArtistConfirmUpdate" runat="server" CssClass="btn" Text="Confirm Update" BackColor="green" ForeColor="White" onmouseover="this.style.backgroundColor='#2ecc71';" onmouseout="this.style.backgroundColor='green';" OnClick="btnArtistConfirmUpdate_Click" Visible="False" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="auto-style7">
                                                                <h6>Address</h6>
                                                            </td>
                                                            <td class="auto-style17">:
                                    <asp:TextBox ID="txtArtistAddress" runat="server" Height="25px" Font-Names="Arial" TextMode="MultiLine" Width="170px"></asp:TextBox>
                                                            </td>
                                                            <td class="auto-style22">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="auto-style8">
                                                                <h6>Zip Code</h6>
                                                            </td>
                                                            <td class="auto-style17">:
                                    <asp:TextBox ID="txtArtistZipCode" runat="server" MaxLength="5" Font-Names="Arial"></asp:TextBox>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="txtArtistZipCode" CssClass="auto-style27" ErrorMessage="5 digits zip code only" ForeColor="#FF3300" ValidationExpression="\d{5}">*</asp:RegularExpressionValidator>
                                                            </td>
                                                            <td class="auto-style22">
                                                                <asp:Button ID="btnArtistCancel" runat="server" CssClass="btn" Text="Cancel" Visible="False" BackColor="#F7B731" onmouseover="this.style.backgroundColor='#ff8243';" onmouseout="this.style.backgroundColor='#F7B731';" OnClick="btnArtistCancel_Click" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="auto-style7">
                                                                <h6>Birth Date</h6>
                                                            </td>
                                                            <td class="auto-style17">:
                                     <asp:TextBox ID="txtArtistDOB" runat="server" TextMode="Date" Width="181px" Font-Names="Arial"></asp:TextBox>
                                                            </td>
                                                            <td class="auto-style1">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="auto-style7">
                                                                <h6>Gender</h6>
                                                            </td>
                                                            <td class="auto-style17">:
                                    <span class="auto-style5" __designer:mapid="1ce"><strong __designer:mapid="1cf"><span class="auto-style8" __designer:mapid="1d0">
                                        <asp:RadioButtonList ID="radArtistInfoGender" runat="server" CellPadding="5" CellSpacing="5" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="rbll">
                                            <asp:ListItem>Male</asp:ListItem>
                                            <asp:ListItem>Female</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </span></strong></span>
                                                            </td>
                                                            <td class="auto-style1">&nbsp;</td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
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
