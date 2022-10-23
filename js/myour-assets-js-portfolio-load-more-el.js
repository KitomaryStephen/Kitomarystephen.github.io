( function( $ ) {
	"use strict";

	var count = 2;
	var total = ajax_portfolio_infinite_scroll_data.max_num;

	//console.log('totalNumber: ' + total);
	var flag = 1;
	var card_wrap = $('.section.works');
	var works = $('.section.works .box-items');

	$('.section.works .load-more').on( 'click', function(){
		if ( count > total ) {
            $(this).closest('.bts').hide();
        } else {
        	if( flag == 1 ){
        		//console.log('pageNumber: ' + count);
            	loadContent(count);

            	if ( count + 1 > total ) {
            		$(this).closest('.bts').fadeOut(500);
            	}
            }
        }
        if( flag == 1 ){
        	flag = 0;
        	count++;
        }

        return false;
	});

	function loadContent(pageNumber) {
	    $.ajax({
	        url: ajax_portfolio_infinite_scroll_data.url,
	        type:'POST',
	        data: "action=infinite_scroll_el&page_no="+ pageNumber + '&post_type=portfolio' + '&page_id=' + ajax_portfolio_infinite_scroll_data.page_id + '&order_by=' + ajax_portfolio_infinite_scroll_data.order_by + '&order=' + ajax_portfolio_infinite_scroll_data.order + '&per_page=' + ajax_portfolio_infinite_scroll_data.per_page + '&source=' + ajax_portfolio_infinite_scroll_data.source + '&temp=' + ajax_portfolio_infinite_scroll_data.temp + '&cat_ids=' + ajax_portfolio_infinite_scroll_data.cat_ids,
	        success: function(html){
	        	//html = html.replace(/js-scroll-show/g, '');

	            var $html = $(html);
	            var $container = works;

	            $html.imagesLoaded(function(){
					$container.append($html);
					$container.isotope('appended', $html );
					$container.isotope('layout');

					updateMagnificPopups();
				});

	            flag = 1;
	        }
	    });
	    return false;
	}

	function updateMagnificPopups() {
	/* popup media */
    $('.has-popup-media').magnificPopup({
        type: 'inline',
        overflowY: 'auto',
        closeBtnInside: true,
        mainClass: 'popup-box-inline',
        callbacks : {
            elementParse: function(item) {
                // Function will fire for each target element
                // "item.el" is a target DOM element (if present)
                // "item.src" is a source that you may modify

                var item_id = item.src.replace('#popup-', '');

                $.ajax({
                    url: portfolio_ajax_loading_data.url,
                    type: 'POST',
                    data: 'action=portfolio_popup&post_id=' + item_id,
                    success: function(html){
                        $(item.src+' .content').html(html);
                    }
                });
            },
            open : function(){

            }
        }
    });

	/*
		Image popup
	*/
	$('.has-popup-image').magnificPopup({
		type: 'image',
		closeOnContentClick: true,
		mainClass: 'mfp-fade',
		image: {
			verticalFit: true
		}
	});

	/*
		Video popup
	*/
	$('.has-popup-video').magnificPopup({
		type: 'iframe',
		iframe: {
            patterns: {
                youtube_short: {
                  index: 'youtu.be/',
                  id: 'youtu.be/',
                  src: 'https://www.youtube.com/embed/%id%?autoplay=1'
                }
            }
        },
		removalDelay: 160,
		preloader: false,
		fixedContentPos: false,
		mainClass: 'mfp-fade',
		callbacks: {
			markupParse: function(template, values, item) {
				template.find('iframe').attr('allow', 'autoplay');
			}
		}
	});

	/*
		Music popup
	*/
	$('.has-popup-music').magnificPopup({
		type: 'iframe',
		removalDelay: 160,
		preloader: false,
		fixedContentPos: false,
		mainClass: 'mfp-fade'
	});

	/*
		Gallery popup
	*/
	$('.has-popup-gallery').on('click', function() {
        var gallery = $(this).attr('href');

        $(gallery).magnificPopup({
            delegate: 'a',
            type:'image',
            closeOnContentClick: false,
            mainClass: 'mfp-fade',
            removalDelay: 160,
            fixedContentPos: false,
            gallery: {
                enabled: true
            }
        }).magnificPopup('open');

        return false;
    });
	}
} )( jQuery );

/*This file was exported by "Export WP Page to Static HTML" plugin which created by ReCorp (https://myrecorp.com) */