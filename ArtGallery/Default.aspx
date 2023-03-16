<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ArtGallery.Default1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .wrapper {
            margin: 0 auto;
        }

        .roundcorner {
            border-radius: 15px;
            margin-top:10px;
        }
    </style>
    <section class="category" id="category">
        <br />
        <br />
        <h1 style="font-size: xx-large; color: white; text-align: center;"><b>Discover The World Through Original Paintings For Sale</b></h1>
        <br />
        <div class="wrapper">
            <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1" RepeatColumns="4" RepeatDirection="Horizontal" CellSpacing="23">
                <itemtemplate>
                    <asp:Image ID="Image1" CssClass="roundcorner" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' Height="250" Width="250" />
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Name") %>' ForeColor="White" Font-Bold="true" Font-Size="19px"></asp:Label>
                </itemtemplate>
            </asp:DataList>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cs %>" SelectCommand="SELECT [Name], [ImageUrl] FROM [Categories] WHERE ([IsActive] = @IsActive)">
                <selectparameters>
                    <asp:Parameter DefaultValue="True" Name="IsActive" Type="Boolean" />
                </selectparameters>
            </asp:SqlDataSource>
            <br />
            <br />
            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Gallery.aspx" ForeColor="White" align="center" Font-Underline="True" onmouseover="this.style.color='#f7b731';" onmouseout="this.style.color='white';">
                <h4><b>SEE ALL OUR PAINTINGS</b></h4>
            </asp:HyperLink>
        </div>
    </section>

    <section class="about" id="about">
        <h1 class="heading"><b><span>about</span> us</b></h1>
        <div class="row">
            <div class="image">
                <img src="Images/about-img.jpg" />
            </div>
            <div class="content">
                <h3>Our DNA: International, Quality, Diversity</h3>
                <p>
                    At Le Louvre, we are convinced that the digital space is an invaluable tool for bringing transparency and equity to the art market.
We provide artists with the tools that enable them to independently manage the sale of their works. Our team is working around the clock, committing their energy to promoting SINGULART artists to a global audience.
                </p>
                <p>In showcasing artists around the world, we also hope to allow art lovers and collectors alike to explore new artistic horizons, to embrace new cultures and to be inspired by the works of talented artists that they never would have come across if it wasn't for LE LOUVRE.</p>
                <a href="#" class="btn">Contact Us</a>
            </div>
        </div>
    </section>

    <section class="review" id="review">
        <h1 class="heading"><b>customer's <span>review</span></b></h1>
        <div class="review-slider swiper-container">
            <div class="swiper-wrapper">
                <div class="swiper-slide box">
                    <i class="fas fa-quote-right"></i>
                    <div class="user">
                        <img src="Images/Profile/pic-1.png" alt="">
                        <div class="user-info">
                            <h3>Vivian Goodwin</h3>
                            <span>Happy Clients</span>
                        </div>
                    </div>
                    <p>
                        I have been looking for a while now and have come across many different websites that sell art. None of them compare to Le Lourve. The prices are reasonable and the quality of their products are the best.
                    </p>
                </div>

                <div class="swiper-slide box">
                    <i class="fas fa-quote-right"></i>
                    <div class="user">
                        <img src="Images/Profile/pic-2.png" alt="">
                        <div class="user-info">
                            <h3>Tasha Meskill</h3>
                            <span>Happy Clients</span>
                        </div>
                    </div>
                    <p>
                        I've been looking for a good art gallery for years now and I finally found the perfect one. Le Lourve has an amazing collection of paintings that are both affordable and of high quality. 
                    </p>
                </div>

                <div class="swiper-slide box">
                    <i class="fas fa-quote-right"></i>
                    <div class="user">
                        <img src="Images/Profile/pic-3.png" alt="">
                        <div class="user-info">
                            <h3>Derick Peters</h3>
                            <span>Happy Clients</span>
                        </div>
                    </div>
                    <p>
                        I've been a fan of Le Lourve for years. I love the way they use colors and shapes to create such beautiful artworks. I'm so happy that I finally own one of their paintings!<br />
                        <br />
                    </p>
                </div>

                <div class="swiper-slide box">
                    <i class="fas fa-quote-right"></i>
                    <div class="user">
                        <img src="Images/Profile/pic-4.png" alt="">
                        <div class="user-info">
                            <h3>Joe Vega</h3>
                            <span>Happy Clients</span>
                        </div>
                    </div>
                    <p>
                        I have been looking for a beautiful piece of art for my home and stumbled upon Le Lourve. I purchased one of their abstract paintings and love it!<br />
                        <br />
                    </p>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
