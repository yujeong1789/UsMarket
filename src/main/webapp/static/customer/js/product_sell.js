/**
 * 
 */

// 10보다 작은 값에 0을 붙임
function _pad(n, width) {
	n = n + '';
	return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
}

// 현재 시간을 리턴
function getCurrentDate() {
	var d = new Date();
	return d.getFullYear() + _pad((1 + d.getMonth()), '2') + _pad(d.getDate(), '2') + d.getHours() + d.getMinutes() + d.getSeconds() + d.getMilliseconds();
}

// 숫자 외 값을 입력하면 알림 띄우고 공백으로 replace하는 함수
function priceRegexCheck(element) {
	const priceRegex = /[^-0-9]/g;
	if (priceRegex.test(element.value)) {
		alert('숫자만 입력해 주세요.');
		element.value = element.value.replace(priceRegex, '');
	}
}

function setBorder(element, bool) {
	let warningElement = document.getElementById(element.id + '_warning');
	if (bool == false) {
		warningElement.style.display = 'block';
		warningElement.setAttribute('data-status', 'not');
		element.style.border = '2px solid red';
	} else {
		warningElement.style.display = 'none';
		warningElement.setAttribute('data-status', 'pass');
		element.style.border = '1px solid #DCDBE4';
	}
}

// 최소, 최대값 충족 여부 검사하는 함수
function lengthCheck(currentValue, minValue, maxValue) {
	if (minValue <= currentValue && currentValue <= maxValue) {
		return true;
	}
	return false;
}

// category1 불러올 때마다 category2 초기화하는 함수
function setBlank() {
	category2__ul.replaceChildren();
	product_category2_no.value = '';
	document.getElementById('selected__category__2').style.display = 'none';
	document.getElementById('product_category_warning').setAttribute('data-status', 'not');
}

// category1 클릭시 수행될 함수
function setDisplayCategory1(element) {
	setBlank();
	product_category1_no.value = element.getAttribute('value');

	document.getElementById('category2__alert').style.display = 'none';
	document.getElementById('selected__category__display').style.display = 'flex';

	let selected__category__1 = document.getElementById('selected__category__1');
	selected__category__1.className = 'selected__category';
	selected__category__1.innerText = element.innerText;

	console.log('category1 input value = ' + product_category1_no.value);
}

// category2 클릭시 수행될 함수
function setDisplayCategory2(element) {
	document.getElementById('product__sell__input__category').style.border = '1px solid #DCDBE4';
	product_category2_no.value = element.getAttribute('value');

	let product_category_warning = document.getElementById('product_category_warning');
	product_category_warning.setAttribute('data-status', 'pass');
	product_category_warning.style.display = 'none';

	let selected__category__2 = document.getElementById('selected__category__2');
	selected__category__2.style.display = 'flex';
	selected__category__2.className = 'selected__category';
	selected__category__2.innerText = element.innerText;

	console.log('category2 input value = ' + product_category2_no.value);
}
