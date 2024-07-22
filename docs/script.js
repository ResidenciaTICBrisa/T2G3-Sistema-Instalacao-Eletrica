function toggleMenu() {
    const navToggle = document.getElementById("nav-toggle");
    const navContent = document.getElementById("nav-content");
    navToggle.classList.toggle("open");
    navContent.classList.toggle("open");
}

document.getElementById("modeToggle").addEventListener("click", function () {
    document.body.classList.toggle("dark-mode");

    if (document.body.classList.contains("dark-mode")) {
        document.getElementById("image1").src = "assets/Electrician-black.gif";
        document.getElementById("image2").src = "assets/Electrician2-black.gif";
        document.querySelector(".gradient-bg").classList.add("dark-mode");
    } else {
        document.getElementById("image1").src = "assets/Electrician.gif";
        document.getElementById("image2").src = "assets/Electrician2.gif";
        document.querySelector(".gradient-bg").classList.remove("dark-mode");
    }
});

$(document).ready(function () {
    $(".team-carousel").slick({
        infinite: true,
        slidesToShow: 3,
        slidesToScroll: 1,
        arrows: true,
        autoplay: true,
        autoplaySpeed: 2000,
        responsive: [
            {
                breakpoint: 1024,
                settings: {
                    slidesToShow: 2,
                    slidesToScroll: 1,
                    infinite: true,
                    dots: true,
                },
            },
            {
                breakpoint: 600,
                settings: {
                    slidesToShow: 1,
                    slidesToScroll: 1,
                },
            },
        ],
    });
});

document.querySelectorAll('a[href^="#"]').forEach((anchor) => {
    anchor.addEventListener("click", function (e) {
        e.preventDefault();
        document.querySelector(this.getAttribute("href")).scrollIntoView({
            behavior: "smooth",
        });
    });
});