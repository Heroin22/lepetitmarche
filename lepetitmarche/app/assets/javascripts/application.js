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
    if(data.length === 0) {
        $('#ad-show').html(html);
    }else{
        $.each(data,function (index, ad) {
            $.ajax({
                method: "POST",
                url: "annonce/getDonneesAd",
                data:{
                    depId: ad['region'],
                    cityId : ad['city'],
                    categId : ad['category']
                },
                success : function (data) {
                    var dep = data["dep"];
                    var city = data["city"];
                    console.log(city);
                    var categ = data["categ"];
                    html += "<div class='col-md-6'><div class='panel panel-default panelPerso'><div class='panel-heading'><a href='annonce?id=";
                    html += ad['id']+"'>"+ad['title']+"</a></div>";
                    html += "<div class='panel-body'><div class='col-md-6'><p><img class='img-responsive center-block imgPersoPetit' src='/data/"+ad['image']+"' alt='image'/></p> </div> <div class='col-md-6'> <li class='list-group-item'><span class='glyphicon glyphicon-globe'></span> <b>Lieu : </b> "

                    html += dep['departement_nom'] + " > " + city['ville_nom_reel'] + "</li><li class='list-group-item'><span class='glyphicon glyphicon-th-large'></span> <b>Catégorie : </b>";
                    html += categ['name'];
                    html += "</li> <li class='list-group-item'><span class='glyphicon glyphicon-piggy-bank'></span> <b>Prix : </b> "+parseFloat(ad['price']).toFixed(1)+" €</li> </div> </div> </div> </div>"
                    $('#ad-show').html(html);
                }
            })
        });
    }
}

function afficheVilleHtml(idDivDep,idDivVille){
    $.ajax({
        method: "POST",
        url: "annonces/getVilleByDep",
        data:{
            depId: $("#"+idDivDep).val()
        },
        success : function (data) {
            var ville = data["ville"];
            $('#'+idDivVille).empty();
            $("#"+idDivVille).append(new Option(" --- Villes ---", ""));
            $.each(ville,function (index, ville) {
                $("#"+idDivVille).append(new Option(ville['ville_nom_simple'], ville['ville_id']));
            })
        }
    });
}

function search(){
    var searchText = $("#searchtext").val();
    var categorieId = $("#categories").val();
    var departementId = $("#regionRecherche").val();
    var villeId= $("#villeRecherche").val();

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
            return ad;
        }
    });
}

$( document ).ready(function() {
    $('#sort-date').click(function() {
        var searchText = $("#searchtext").val();
        var categorieId = $("#categories").val();
        var departementId = $("#regionRecherche").val();
        var villeId= $("#villeRecherche").val();
        if($(this).html().indexOf("glyphicon glyphicon-chevron-up") >= 0){
            $("#sort-date").html("Date <span class='glyphicon glyphicon-chevron-down'></span>");
            $("#sort-prix").html("Prix <span class='glyphicon glyphicon-minus'></span>");
            $.ajax({
                method: "POST",
                url: "annonces/searchWithSort",
                data : {
                    orderBy: "dateUp",
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
        }else{
            $("#sort-date").html("Date <span class='glyphicon glyphicon-chevron-up'></span>");
            $("#sort-prix").html("Prix <span class='glyphicon glyphicon-minus'></span>");
            $.ajax({
                method: "POST",
                url: "annonces/searchWithSort",
                data : {
                    orderBy: "dateDown",
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
        }
    });
    $('#sort-prix').click(function() {
        var searchText = $("#searchtext").val();
        var categorieId = $("#categories").val();
        var departementId = $("#regionRecherche").val();
        var villeId= $("#villeRecherche").val();
        if($(this).html().indexOf("glyphicon glyphicon-chevron-up") >= 0){
            $("#sort-prix").html("Prix <span class='glyphicon glyphicon-chevron-down'></span>");
            $("#sort-date").html("Date <span class='glyphicon glyphicon-minus'></span>");
            $.ajax({
                method: "POST",
                url: "annonces/searchWithSort",
                data : {
                    orderBy: "priceUp",
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
        }else{
            $("#sort-prix").html("Prix <span class='glyphicon glyphicon-chevron-up'></span>");
            $("#sort-date").html("Date <span class='glyphicon glyphicon-minus'></span>");
            $.ajax({
                method: "POST",
                url: "annonces/searchWithSort",
                data : {
                    orderBy: "priceDown",
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
        }
    });

    $("#btn-search").click(function () {
        var searchText = $("#searchtext").val();
        var categorieId = $("#categories").val();
        var departementId = $("#regionRecherche").val();
        var villeId= $("#villeRecherche").val();
        $("#sort-prix").html("Prix <span class='glyphicon glyphicon-minus'></span>");
        $("#sort-date").html("Date <span class='glyphicon glyphicon-minus'></span>");

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
    });

    $("#regionAdd").change(function() {
        afficheVilleHtml("regionAdd","villeAdd");
    });

    $("#regionRecherche").change(function () {
        afficheVilleHtml("regionRecherche","villeRecherche");
    })
});