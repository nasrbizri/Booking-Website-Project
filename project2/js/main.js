const api_endpoint = "/project2/api/";
const main = "/project2/";
const internet_connection_error = "please check your internet connection";
const alertMsg = (id, type, msg) => {
    const alertContainer = $(`#${id}`);
    alertContainer.attr('class', `alert alert-${type}`);
    alertContainer.text(msg);
    alertContainer.attr('style', 'display:block');
}

const messageOrConcern = (formId, formAlertId, endpoint, event) => {
    $(`#${formId} > div > button`).attr('disabled', true);
    event.preventDefault();
    const formData = $(`#${formId}`).serializeArray();
    const data = {};
    $.each(formData, function (i, field) {
        data[field.name] = field.value;
    });

    if(formId === "signup_form"){
        data['agreed'] = 1;
        delete data['repeated_password'];
    }

    $.ajax({
        type: 'POST',
        url: `${api_endpoint}${endpoint}`,
        contentType: 'application/json',
        data: JSON.stringify(data),
        success: function (data) {
            $(`#${formId} > div > button`).attr('disabled', false);

            if (data.status == 'error') {
                alertMsg(formAlertId, 'danger', data.message);
                return;
            }

            $(`#${formId} > div > input, #${formId} > div > textarea`).map((i, e) => {
                e.value = "";
            })

            alertMsg(formAlertId, 'success', data.message);

            if(formId === "signup_form"){
                setTimeout(function () { window.location.href = `${main}pages/signIn.php` }, 3000);
            }
            
        },
        error: function (jqXHR, textStatus, errorThrown) {
            $(`#${formId} > div > button`).attr('disabled', false);
            if (jqXHR.status === 400 || jqXHR.status === 500) {
                alertMsg(formAlertId, 'danger', JSON.parse(jqXHR.responseText).message);
                return;
            }

            alertMsg(formAlertId, 'danger', internet_connection_error);
        }
    });
};


const checkSignUp = () => {
    let empty = false;

    $('input').map((i, e) => {
        if (e.value.trim() === "") {
            empty = true;
        }
    });

    if (empty) {
        $('#signup_form > div > button').attr('disabled', true);
        return;
    } 

    const passwordInput = $('#signup_form > div > [name="password"]');
    const repeatedPasswordInput = $('#signup_form > div > [name="repeated_password"]');

    if (passwordInput.val() !== repeatedPasswordInput.val()) {
        passwordInput.attr('style', 'border:2px solid red');
        repeatedPasswordInput.attr('style', 'border:2px solid red');
        $('#signup_form > div > button').attr('disabled', true);
        return;
    } else {
        passwordInput.attr('style', '');
        repeatedPasswordInput.attr('style', '');
    }

    if (!$('#signup_form > div > div > div > [type="email"]')[0].checkValidity()) {
        $('#signup_form > div > div > div > [type="email"]').attr('style', 'border:2px solid red');
        $('#signup_form > div > button').attr('disabled', true);
        return;
    } else {
        $('#signup_form > div > button').attr('disabled', false);
        $('#signup_form > div > div > div > [type="email"]').attr('style', '');
    }

    if($('#signup_form > div > div > div > [name="birthdate"]').val() === ""){
        $('#signup_form > div > div > div > [name="birthdate"]').attr('style', 'border:2px solid red');
        $('#signup_form > div > button').attr('disabled', true);
        return;
    } else{
        $('#signup_form > div > div > div > [name="birthdate"]').attr('style', '');
        $('#signup_form > div > button').attr('disabled', false);
    }

    if (!$('#signup_form > div > div > div > [name="phone"]').val().match(/^[0-9]{8,20}$/)) {
        $('#signup_form > div > div > div > [name="phone"]').attr('style', 'border:2px solid red');
        $('#signup_form > div > button').attr('disabled', true);
        return;
    } else {
        $('#signup_form > div > div > div > [name="phone"]').attr('style', '');
        $('#signup_form > div > button').attr('disabled', false);
    }

    if (!$('#signup_form > div > [name="agreed"]').is(':checked')) {
        $('#signup_form > div > button').attr('disabled', true);
    } else {
        $('#signup_form > div > button').attr('disabled', false);
    }



};

const signIn = (email, password) => {
    $.ajax({
        type: 'POST',
        url: `${api_endpoint}signin`,
        contentType: 'application/json',
        data: JSON.stringify({email: email, password: password}),
        success: function (data) {
            $(`#signin_form > button`).attr('disabled', false);

            if (data.status == 'error') {
                alertMsg(`signin_form_alert`, 'danger', data.message);
                return;
            }

            alertMsg(`signin_form_alert`, 'success', data.message);
            setTimeout(function () { window.location.href = `${main}pages/tripshistory.php` }, 3000);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            $(`#signin_form > button`).attr('disabled', false);
            if (jqXHR.status === 400 || jqXHR.status === 500) {
                alertMsg(`signin_form_alert`, 'danger', JSON.parse(jqXHR.responseText).message);
                return;
            }

            alertMsg(`signin_form_alert`, 'danger', internet_connection_error);
        }
    });
}

const signOut = () => {
    $.ajax({
        type: 'GET',
        url: `${api_endpoint}signout`,
        contentType: 'application/json',
        success: function (data) {
            if (data.status == 'error') {
                alert(data.message);
                return;
            }

            alert(data.message);
            window.location = main;
        },
        error: function (jqXHR, textStatus, errorThrown) {
            if (jqXHR.status === 400 || jqXHR.status === 500) {
                alert(JSON.parse(jqXHR.responseText).message);
                return;
            }

            alert(internet_connection_error);
        }
    });
}

const addBookingRecord = () => {
    const formData = $('#book_form').serializeArray();
    const data = {};
    $.each(formData, function (i, field) {
        data[field.name] = field.value;
    });
    
    if (data['check_in_date'] === '' || data['check_out_date'] === ''){
        alertMsg(`book_form_alert`, 'danger', 'please select dates correctly');
        return;
    }

    $.ajax({
        type: 'POST',
        url: `${api_endpoint}add/booking_record`,
        contentType: 'application/json',
        data: JSON.stringify(data),
        success: function (data) {
            if (data.status == 'error') {
                alertMsg(`book_form_alert`, 'danger', data.message);
                return;
            }

            alertMsg(`book_form_alert`, 'success', data.message);
            $('#book_form [name="check_in_date"]').val('');
            $('#book_form [name="check_out_date"]').val('');
            setTimeout(function() {
                window.location = `${main}pages/tripshistory.php`;
            }, 5000);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            if (jqXHR.status === 400 || jqXHR.status === 500 || jqXHR.status === 403) {
                alertMsg(`book_form_alert`, 'danger', JSON.parse(jqXHR.responseText).message);
                return;
            }

            alertMsg(`book_form_alert`, 'danger', internet_connection_error);
        }
    });
}

const watchDates =  () => {
    if ($('#book_form [name="check_in_date"]').val() === '' || $('#book_form [name="check_out_date"]').val() === '') {
        $('#total_price').text("$0");
        $('#book_form > button').attr('disabled', true);
        return;
    }
    const startDate = new Date($('#book_form [name="check_in_date"]').val());
    const endDate = new Date($('#book_form [name="check_out_date"]').val());
    const timeDifference = endDate - startDate;
    let numberOfDays = Math.floor(timeDifference / (1000 * 60 * 60 * 24));
    if (numberOfDays === 0) {
        numberOfDays = 1;
    }

    if (numberOfDays < 0) {
        $('#total_price').text("$0");
        $('#book_form > button').attr('disabled', true);
        return;
    }
    const totalPrice = numberOfDays * parseInt($('#price_per_night').val());
    $('#total_price').text(`\$${totalPrice}`);
    $('#book_form > button').attr('disabled', false);
}

const modifyPassword = () => {
    const formData = $('#new_password_form').serializeArray();
    const data = {};
    $.each(formData, function (i, field) {
        data[field.name] = field.value;
    });

    $.ajax({
        type: 'POST',
        url: `${api_endpoint}user/modify_password`,
        contentType: 'application/json',
        data: JSON.stringify(data),
        success: function (data) {
            $(`#new_password_form > button`).attr('disabled', false);

            if (data.status == 'error') {
                alertMsg(`new_password_form_alert`, 'danger', data.message);
                return;
            }

            alertMsg(`new_password_form_alert`, 'success', data.message);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            $(`#signin_form > button`).attr('disabled', false);
            if (jqXHR.status === 400 || jqXHR.status === 500 || jqXHR.status === 403) {
                alertMsg(`new_password_form_alert`, 'danger', JSON.parse(jqXHR.responseText).message);
                return;
            }

            alertMsg(`new_password_form_alert`, 'danger', internet_connection_error);
        }
    });
}

const addToWishlist = (placeID) => {
    data = {place_id: placeID};
    $.ajax({
        type: 'POST',
        url: `${api_endpoint}user/add/wishlist`,
        contentType: 'application/json',
        data: JSON.stringify(data),
        success: function (data) {

            if (data.status == 'error') {
                alert(data.message);
                return;
            }

            alert(data.message);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            if (jqXHR.status === 400 || jqXHR.status === 500 || jqXHR.status === 403) {
                alert(JSON.parse(jqXHR.responseText).message);
                return;
            }

            alert(internet_connection_error);
        }
    });
}


const removeWishListItem = (placeID, event) => {
    data = { place_id: placeID };
    $.ajax({
        type: 'POST',
        url: `${api_endpoint}user/delete/wishlist`,
        contentType: 'application/json',
        data: JSON.stringify(data),
        success: function (data) {

            if (data.status == 'error') {
                alert(data.message);
                return;
            }

            $(event.currentTarget.parentNode).remove();
            alert(data.message);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            if (jqXHR.status === 400 || jqXHR.status === 500 || jqXHR.status === 403) {
                alert(JSON.parse(jqXHR.responseText).message);
                return;
            }

            alert(internet_connection_error);
        }
    });
}


const newCardElement = (place, cardTemplate) => {
    const newCard = cardTemplate.clone();
    const flag = `${main}img/flags/` + place.country.toLowerCase() + ".png";
    newCard.children('[data-title]').text(place.title);
    newCard.children('[data-description]').text(place.description);
    newCard.children('[data-price]').text(Math.floor(place.price_per_night));
    newCard.children('[data-image]').attr('src', `${main}${place.image}`);
    newCard.children('[data-country]').attr('src', flag);
    newCard.children('[data-country-code]').val(place.country);
    newCard.removeAttr('style');
    newCard.on('click', (event) => {
        window.location = `${main}pages/book.php?id=${place.id}`;
    });
    newCard.children('[name="addToWishListBtn"]').on('click', (event) => {
        event.stopPropagation();
        addToWishlist(place.id);
    });

    return newCard;
}
const getRentablePlaces = () => {
    const cardTemplate = $($('.card')[0]).clone();
    const query = $('#search-input').val();
    data = { query: query };
    $.ajax({
        type: 'GET',
        url: `${api_endpoint}rentable_places`,
        contentType: 'application/json',
        data: data,
        success: function (data) {
            if (data.status == 'error') {
                alert(data.message);
                $('#filter-btn').attr('disabled', true);
                return;
            }

            $('#filter-btn').attr('disabled', false);
            localStorage.setItem('placesData', JSON.stringify(data.data));
            const placesContainer = $('#places-container');
            placesContainer.empty();
            const places = data.data; 
            for(const place of places){
                const newCard = newCardElement(place, cardTemplate);
                placesContainer.append(newCard);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            if (jqXHR.status === 400 || jqXHR.status === 500 || jqXHR.status === 403) {
                alert(JSON.parse(jqXHR.responseText).message);
                return;
            }

            $('#filter-btn').attr('disabled', true);
            alert(internet_connection_error);
        }
    });

}

const searchDisable = (event) => {
    const input = $(event.currentTarget);
    if (input.val().trim() === '') {
        getRentablePlaces();
    }

    if (input.val().length < 4) {
        $('#search-btn').attr('disabled', true);
        return;
    }

    $('#search-btn').attr('disabled', false);
}

const filterPlaces = () => {
    const country = $('#filter-by').val();
    const sortBy = $('#sort-by').val();
    const placesContainer = $('#places-container');
    let data = JSON.parse(localStorage.getItem('placesData'));

    if(country !== 'all'){
        data = data.filter(function (place) {
            return place.country === country;
        });
    }

    data.sort(function(a, b) {
        if(sortBy === 'ASC'){
            return a.price_per_night - b.price_per_night;
        }

        return b.price_per_night - a.price_per_night;
    });

    const cardTemplate = $($('.card')[0]).clone();
    placesContainer.empty();
    for(const place of data){
        const newCard = newCardElement(place, cardTemplate);
        placesContainer.append(newCard);
    }
}


const getCurrentPage = () => {
    const endpoints = window.location.href.split('/');
    let pageName = endpoints[endpoints.length - 1];
    pageName = pageName.replace('.php','');
    if(pageName.trim() === ''){
        pageName = 'home';
    }

    const navItems = $('[data-page]');
    navItems.map((i,e) => {
        const currentPage = $(e).attr('data-page');
        if(currentPage === pageName){
            const oldClass = $(e).attr('class');
            $(e).attr('class', `${oldClass} active`);
        }
    });

    return pageName;
}

$(document).ready(function() {
    $('#contact_form > div > button').on('click', (event) => {
        messageOrConcern('contact_form', 'contact_form_alert', 'contact', event);
    });

    $('#concern_form > div > button').on('click', (event) => {
        messageOrConcern('concern_form', 'concern_form_alert', 'concern', event);
    });

    if ($('#signup_form').length !== 0){
        setInterval(checkSignUp, 300);
    }

    $('#signup_form > div > button').on('click', (event) => {
        messageOrConcern('signup_form', 'signup_form_alert', 'signup', event);
    });

    $('#signin_form > button').on('click', (event) => {
        event.preventDefault();
        signIn($('#signin_form > div > [name="email"]').val(), $('#signin_form > div > [name="password"]').val());
    });

$('#signout_header_btn').on('click', signOut);

    $('#new_password_form > button').on('click', (event) => {
        event.preventDefault();
        modifyPassword();
    });

    $('#book_form > button').on('click', (event) => {
        event.preventDefault();
        addBookingRecord();
    })

    if($('#book_form').length !== 0){
        setInterval(watchDates, 300);
    }

    $('[data-item="book_item"]').on('click', (event) => {
        const placeID = event.currentTarget.getAttribute('data-place-id');
        window.location = `${main}pages/book.php?id=${placeID}`;
    });

    $('[name="addToWishListBtn"]').on('click', (event) => {
        event.stopPropagation();
        addToWishlist(event.currentTarget.parentNode.getAttribute('data-place-id'));
    });

    $('[name="removeWishListBtn"]').on('click', (event) => {
        event.stopPropagation();
        removeWishListItem(event.currentTarget.parentNode.getAttribute('data-place-id'), event);
    });

    $('[data-item="offer_item"]').on('click', (event) => {
        const offerId = event.currentTarget.getAttribute('data-offer-id');
        const placeID = event.currentTarget.getAttribute('data-place-id');
        window.location = `${main}pages/book.php?id=${placeID}&offer_id=${offerId}`;
    });

    if ($('#modifyPasswordModal').length !== 0){
        $('#modifyPasswordModal').modal('show');
    }

    $('#search-btn').on('click', (event) => {
        getRentablePlaces();
    });

    $('#search-input').on('input', (event) => {
        searchDisable(event);
    });

    $('#filter-btn').on('click', filterPlaces);

    const page = getCurrentPage();
    if(page === 'book'){
        getRentablePlaces();
    }

});








