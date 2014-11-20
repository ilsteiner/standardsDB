var configs = [
{"element1":"Al", "element2":"","plated":""},
{"element1":"Ag", "element2":"","plated":""},
{"element1":"Ag", "element2":"Cu","plated":""},
{"element1":"Au", "element2":"","plated":""},
{"element1":"Au", "element2":"Ni","plated":""},
{"element1":"Au", "element2":"Cu","plated":""},
{"element1":"Au", "element2":"Sn","plated":""},
{"element1":"Bi", "element2":"","plated":""},
{"element1":"Co", "element2":"","plated":""},
{"element1":"Cr", "element2":"","plated":""},
{"element1":"Cr", "element2":"Cu","plated":""},
{"element1":"Cr", "element2":"Fe","plated":""},
{"element1":"Cu", "element2":"","plated":""},
{"element1":"Cu", "element2":"Fe","plated":""},
{"element1":"Cu", "element2":"Zn","plated":""},
{"element1":"Fe", "element2":"","plated":""},
{"element1":"In", "element2":"","plated":""},
{"element1":"Ir", "element2":"","plated":""},
{"element1":"Mg", "element2":"","plated":""},
{"element1":"Mo", "element2":"","plated":""},
{"element1":"Ni", "element2":"","plated":""},
{"element1":"Ni", "element2":"Al","plated":""},
{"element1":"Ni", "element2":"Cu","plated":""},
{"element1":"Ni", "element2":"Fe","plated":""},
{"element1":"Ni", "element2":"","plated":"Al"},
{"element1":"Ni", "element2":"","plated":"Cu"},
{"element1":"Ni", "element2":"","plated":"Fe"},
{"element1":"Pb", "element2":"","plated":""},
{"element1":"Pb", "element2":"Cu","plated":""},
{"element1":"Pd", "element2":"","plated":""},
{"element1":"Rh", "element2":"","plated":""},
{"element1":"Ru", "element2":"","plated":""},
{"element1":"Sn", "element2":"","plated":""},
{"element1":"Sn", "element2":"Cu","plated":""}
];

var targetValue = 2;
var price = 0;

for(var k in configs){
    targetValue = 2;
    price = Math.ceil((Math.random() * (1000 - 500) + 500+1)/10)*10;
    for(var i=1;i<=20;i++){
        $("#data").append('F,');
        $("#data").append(price + ',');
        price -= (price * 0.1);
        price = Math.ceil((price+1)/10)*10;
        $("#data").append(Math.round(Math.floor(Math.random()*51)));
        $("#data").append('<br>');
    }
}