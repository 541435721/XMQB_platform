/**
 * Created by bxsh on 2016/8/23.
 */

if (!Detector.webgl) Detector.addGetWebGLMessage();

function doNothing() {
    window.event.returnValue = false;
    return false;
}

var container, stats;

var camera, cameraTarget, scene, renderer;

var camera_p_x = 100;
var camera_p_y = 0;
var camera_p_z = 0;
var count = 0;
var sta = 0;

var mesh_r_x = -Math.PI / 2;
var mesh_r_y = 0;
var mesh_r_z = 0;

var start_x = 0;
var start_y = 0;
var color = {
    'Bisque': 0xFFE4C4,
    'Red': 0xff5533,
    'Chocolate': 0xD2691E,
    'DarkSlateBlue': 0x483D8B,
    'Feldspar': 0xD19275,
    'HotPink': 0xFF69B4
};

//var d = document.getElementById('p');
//d.setAttribute('name', 'd');

var X = 0;
var Y = 0;

var controls;
container = document.createElement('div');
container.setAttribute("id", "div");

//document.body.appendChild(container);
var canvas_div = document.getElementById('canvas_div');
canvas_div.appendChild(container);


camera = new THREE.PerspectiveCamera(50, window.innerWidth * 10 / 12 / window.innerHeight, 0.1, 10000);
camera.position.set(camera_p_x, camera_p_y, camera_p_z);

cameraTarget = new THREE.Vector3(0, 0, 0);

scene = new THREE.Scene();

var intensity = 0.5;

var light = new THREE.AmbientLight(0x404040); // soft white light


var light1 = new THREE.DirectionalLight(0xffffff, intensity);
var light2 = new THREE.DirectionalLight(0xffffff, intensity);
var light3 = new THREE.DirectionalLight(0xffffff, intensity);
var light4 = new THREE.DirectionalLight(0xffffff, intensity);
var light5 = new THREE.DirectionalLight(0xffffff, intensity);
var light6 = new THREE.DirectionalLight(0xffffff, intensity);

var or = 1;
light1.position.set(0, 0, or);
light2.position.set(0, or, 0);
//light3.position.set(or, 0, 0);
light4.position.set(0, 0, -1 * or);
light5.position.set(0, -1 * or, 0);
light6.position.set(-1 * or, 0, 0);

scene.add(light1);
scene.add(light2);
scene.add(light3);
scene.add(light4);
scene.add(light5);
scene.add(light6);

scene.add(light);


renderer = new THREE.WebGLRenderer({antialias: true});
renderer.setClearColor(0x000000);
renderer.setSize(window.innerWidth * 10 / 12, window.innerHeight - 30);

renderer.domElement.setAttribute('id', 'cvs');
//renderer.domElement.addEventListener('mousewheel', scaleCanvas, false);

container.appendChild(renderer.domElement);
controls = new THREE.OrbitControls(camera, renderer.domElement);
controls.addEventListener('change', render);
controls.autoRotate = true;


stats = new Stats();
stats.domElement.style.position = 'absolute';
stats.domElement.style.top = '0px';
//container.appendChild(stats.domElement);
camera.position.set(camera_p_x, camera_p_y, camera_p_z);

camera.position.set(camera_p_x, camera_p_y, camera_p_z);
camera.lookAt(cameraTarget);


function init(path, c) {
    var loader = new THREE.STLLoader();
    var mesh;
    loader.load(path, function (geo) {

        geo.center();
        var num = path.lastIndexOf(".stl");
        var p = document.getElementById('dis'+path.substring(num-1,num));
        p.innerHTML = "X:" + calculateSize(geo)[0] + " Y:" + calculateSize(geo)[1] + " Z:" + calculateSize(geo)[2];

        var material = new THREE.MeshPhongMaterial({
            color: color[c],
            specular: 0x001111,
            shininess: 100,
            wireframe: false
        });
        mesh = new THREE.Mesh(geo, material);


        mesh.position.set(0, 0, 0);
        mesh.rotation.set(mesh_r_x, mesh_r_y, mesh_r_z);
        mesh.scale.set(0.2, 0.2, 0.2);

        mesh.castShadow = true;
        mesh.receiveShadow = true;
        mesh.name = 'actor';
        scene.add(mesh);

    });

}


function render() {

    var timer = Date.now() * 0.005;
    controls.autoRotate = false;
    //camera.position.x = Math.cos(timer) * 3;
    //camera.position.y = Math.sin( timer ) * 3;
    renderer.render(scene, camera);


}
function scaleCanvas(event) {
    var e = window.event || event; // old IE support
    var delta = Math.max(-1, Math.min(1, (e.wheelDelta || -e.detail)));
    //var p = document.getElementById('te');

    if (delta == 1) {//放大
        camera_p_x -= 2;
        //camera_p_y -= 1;
        //camera_p_z -= 1;
    }
    if (delta == -1) {//缩小
        camera_p_x += 2;
        //camera_p_y += 1;
        //camera_p_z += 1;
    }

    //p.innerHTML = delta + "->" + e.wheelDelta + '->' + e.detail + ' ' + camera_p_x;
}

function animate() {

    requestAnimationFrame(animate);
    render();
    controls.update();
    stats.update();

}

function calculateVol(geo) {
    var x1, x2, x3, y1, y2, y3, z1, z2, z3, i;
    var len = geo.faces.length;
    var totalVolume = 0;
    var totalArea = 0;
    var a, b, c, s;

    for (i = 0; i < len; i++) {
        x1 = geo.vertices[geo.faces[i].a].x;
        y1 = geo.vertices[geo.faces[i].a].y;
        z1 = geo.vertices[geo.faces[i].a].z;
        x2 = geo.vertices[geo.faces[i].b].x;
        y2 = geo.vertices[geo.faces[i].b].y;
        z2 = geo.vertices[geo.faces[i].b].z;
        x3 = geo.vertices[geo.faces[i].c].x;
        y3 = geo.vertices[geo.faces[i].c].y;
        z3 = geo.vertices[geo.faces[i].c].z;

        totalVolume +=
            (-x3 * y2 * z1 +
            x2 * y3 * z1 +
            x3 * y1 * z2 -
            x1 * y3 * z2 -
            x2 * y1 * z3 +
            x1 * y2 * z3);

        a = geo.vertices[geo.faces[i].a].distanceTo(geo.vertices[geo.faces[i].b]);
        b = geo.vertices[geo.faces[i].b].distanceTo(geo.vertices[geo.faces[i].c]);
        c = geo.vertices[geo.faces[i].c].distanceTo(geo.vertices[geo.faces[i].a]);
        s = (a + b + c) / 2;
        totalArea += Math.sqrt(s * (s - a) * (s - b) * (s - c));
    }

    return [Math.abs(totalVolume / 6).toFixed(2), totalArea.toFixed(2)];
}


function calculateSize(geo) {

    var x_l = geo.boundingBox.max.x - geo.boundingBox.min.x;
    var y_l = geo.boundingBox.max.y - geo.boundingBox.min.y;
    var z_l = geo.boundingBox.max.z - geo.boundingBox.min.z;
    return new Array(x_l.toFixed(2), y_l.toFixed(2), z_l.toFixed(2));
}