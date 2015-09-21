var c = document.getElementById('main-canvas');
c.width = window.innerWidth;
c.height = window.innerHeight; 
var ctx = c.getContext('2d');

function animate(myRectangle, canvas, context) {

	// clear
	context.clearRect(0, 0, canvas.width, canvas.height);


	drawCircle(myRectangle, context);

	// // request new frame
	// window.requestAnimationFrame(function() {
	//   animate(myRectangle, canvas, context);
	// });
}
var drawCircle = function(conf, ctx) {
	ctx.beginPath();
	ctx.arc(conf.x,conf.y,40,0,2*Math.PI);
	ctx.closePath();
	ctx.stroke();
	ctx.fillStyle = '#333333';
};

var mousePos = function(canvas, evt) {
	var rect = canvas.getBoundingClientRect();

	animate({
		x: evt.clientX - rect.left,
		y: evt.clientY - rect.top
	}, c, ctx);
};

c.addEventListener('mousemove', function(evt) {
	console.log(mousePos(c,evt));
});


// animate(, c, ctx);