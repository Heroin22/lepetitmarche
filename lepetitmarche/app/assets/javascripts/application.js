// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .


function afficheAdHtml(data){
    var html = "";
    $.each(data,function (index, ad) {
        html += "<div class='col-md-4'><div class='panel panel-default'><div class='panel-heading'>";
        html += ad['title'];
        html += "</div><div class='panel-body'><img src='' alt='image'/><br/><p style='text-align: right'>Prix : <b>";
        html += parseFloat(ad['price']).toFixed(1);
        html += " €</b></p></div></div></div>";
    });
    $('#ad-show').html(html);
}

$( document ).ready(function() {
    $('#sort-date').click(function() {
        if($(this).html().indexOf("glyphicon glyphicon-chevron-up") >= 0){
            $("#sort-date").html("Date <span class='glyphicon glyphicon-chevron-down'></span>");
            $("#sort-prix").html("Prix <span class='glyphicon glyphicon-minus'></span>");
            $.ajax({
                method: "GET",
                url: "annonces/trieDateDown",
                success : function (data) {
                    var ad = data["ad"];
                    afficheAdHtml(ad);
                }
            });
        }else{
            $("#sort-date").html("Date <span class='glyphicon glyphicon-chevron-up'></span>");
            $("#sort-prix").html("Prix <span class='glyphicon glyphicon-minus'></span>");
            $.ajax({
                method: "GET",
                url: "annonces/trieDateUp",
                success : function (data) {
                    var ad = data["ad"];
                    afficheAdHtml(ad);
                }
            });
        }
    });
    $('#sort-prix').click(function() {
        if($(this).html().indexOf("glyphicon glyphicon-chevron-up") >= 0){
            $("#sort-prix").html("Prix <span class='glyphicon glyphicon-chevron-down'></span>");
            $("#sort-date").html("Date <span class='glyphicon glyphicon-minus'></span>");
            $.ajax({
                method: "GET",
                url: "annonces/triePriceUp",
                success : function (data) {
                    var ad = data["ad"];
                    afficheAdHtml(ad);
                }
            });
        }else{
            $("#sort-prix").html("Prix <span class='glyphicon glyphicon-chevron-up'></span>");
            $("#sort-date").html("Date <span class='glyphicon glyphicon-minus'></span>");
            $.ajax({
                method: "GET",
                url: "annonces/triePriceDown",
                success : function (data) {
                    var ad = data["ad"];
                    afficheAdHtml(ad);
                }
            });
        }
    });

    $("#btn-search").click(function () {
        var searchText = $("#searchtext").val();
        var categorieId = $("#categories").val();
        var departementId = $("#region").val();
        var villeId= $("#ville").val();

        $.ajax({
            method: "POST",
            url: "annonces/search",
            data:{
                searchText: searchText,
                categorieId: categorieId,
                departementId: departementId,
                villeId: villeId
            },
            success : function (data) {
                var ad = data["ad"];
                afficheAdHtml(ad);
            }
        });
    })

    $("#region").change(function() {
        $.ajax({
            method: "POST",
            url: "annonces/getVilleByDep",
            data:{
                depId: $(this).val()
            },
            success : function (data) {
                var ville = data["ville"];
                $('#ville').empty();
                $("#ville").append(new Option("Villes", ""));
                $.each(ville,function (index, ville) {
                    $("#ville").append(new Option(ville['ville_nom_simple'], ville['ville_id']));
                })
            }
        });
    });


});

