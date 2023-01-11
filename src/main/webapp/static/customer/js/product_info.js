/**
 * 
 */

function setSellerInfo(json) {
	document.getElementById('fetch__review__count').innerText = json.REVIEW_COUNT;
	document.getElementById('fetch__member__nickname').innerText = json.MEMBER_NICKNAME;
	document.getElementById('fetch__product__count').innerText = json.PRODUCT_COUNT;
};



function setReview(el) {
	let parentDiv = document.createElement('div');

	// 1. 이미지
	let product__review__1 = document.createElement('div');
	product__review__1.className = 'product__review__1';

	let imgUrl = document.createElement('a');
	imgUrl.setAttribute('href', '#'); // 회원 상세보기 링크 추가할 것

	let img = document.createElement('img');
	img.setAttribute('alt', '판매자 이미지');
	img.setAttribute('src', '/usMarket/resources/customer/img/default_profile.png');

	imgUrl.appendChild(img);
	product__review__1.appendChild(imgUrl);
	parentDiv.appendChild(product__review__1);


	let product__review__2 = document.createElement('div');
	product__review__2.className = 'product__review__2';

	let review__info__1 = document.createElement('div');
	review__info__1.className = 'review__info__1';


	// 2. 닉네임
	let review__nickname = document.createElement('a');
	review__nickname.id = 'review__nickname';
	review__nickname.setAttribute('href', '#'); // 회원 상세보기 링크 추가할 것
	review__nickname.textContent = el.MEMBER_NICKNAME;
	review__info__1.appendChild(review__nickname);


	// 3. 등록일
	let review__regdate = document.createElement('span');
	review__regdate.id = review__regdate;
	review__regdate.textContent = convert(el.REVIEW_REGDATE);
	review__info__1.appendChild(review__regdate);

	product__review__2.appendChild(review__info__1);


	let review__info__2 = document.createElement('div');
	review__info__2.className = 'review__info__2';


	// 4. 별점
	let review__score = document.createElement('div');
	review__score.id = 'review__score';
	setScore(el.REVIEW_SCORE, review__score);
	
	review__info__2.appendChild(review__score);


	// 5. 리뷰
	let review__content = document.createElement('div');
	review__content.id = 'review__content';
	review__content.textContent = el.REVIEW_CONTENT;
	review__info__2.appendChild(review__content);

	product__review__2.appendChild(review__info__2);
	
	parentDiv.appendChild(product__review__2);

	//product__review.appendChild(parentDiv);
	
	return parentDiv;
};





function setScore(score, element) {
	for (var i = 1; i <= 5; i++) {
		let scoreImg = document.createElement('img');

		if (score >= i) {
			scoreImg.setAttribute('src', '/usMarket/resources/customer/img/star.png');
		} else if (score < i) {
			scoreImg.setAttribute('src', '/usMarket/resources/customer/img/star_blank.png');
		}
	
		element.appendChild(scoreImg);
	}

};