import * as THREE from 'three';
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';
import { GLTFLoader } from 'three/addons/loaders/GLTFLoader.js';

class App {
    constructor() {
        const divContainer = document.querySelector(".my-work-history");
        this._divContainer = divContainer;

        const renderer = new THREE.WebGLRenderer({ antialias: true });
        renderer.setPixelRatio(window.devicePixelRatio);
        divContainer.appendChild(renderer.domElement);

        this._renderer = renderer;

        const scene = new THREE.Scene();
        scene.background = new THREE.Color(0xffffff);
        this._scene = scene;

        this._setupCamera();
        this._setupLight();
        this._setupControls();

        window.onresize = this.resize.bind(this);
        this.resize();

        requestAnimationFrame(this.render.bind(this));

        this._currentModel = null;  // 현재 모델을 추적하기 위한 속성 추가
    }

    _setupCamera() {
        const camera = new THREE.PerspectiveCamera(
            40,
            window.innerWidth / window.innerHeight,
            1,
            1000
        );

        camera.position.set(0, 0, 300);
        this._camera = camera;
    }

    _setupLight() {
        const color = 0xffffff;
        const intensity = 5;
        const light = new THREE.AmbientLight(color, intensity);
        light.position.set(0, 0, 1);
        this._scene.add(light);
    }

    _setupControls() {
        this._controls = new OrbitControls(this._camera, this._divContainer);
        this._controls.enableDamping = true;
    }

    _setupModel(url) {
        const fullPath = cpath + '/pose/' + url; // cpath를 사용하여 전체 경로 생성
        const loader = new GLTFLoader();
        loader.load(fullPath, (gltf) => {
            const model = gltf.scene;
            this._scene.add(model);
        });
    }

    update(time) {
        time *= 0.001; // second unit

        if (this._controls) {
            this._controls.update();
        }

        this._previousTime = time;
    }

    render(time) {
        this._renderer.render(this._scene, this._camera);
        this.update(time);

        requestAnimationFrame(this.render.bind(this));
    }

    resize() {
    const width = this._divContainer.clientWidth; // 컨테이너의 실제 너비 사용
    const height = this._divContainer.clientHeight; // 컨테이너의 실제 높이 사용

    this._camera.aspect = width / height;
    this._camera.updateProjectionMatrix();

    this._renderer.setSize(width, height);
}

    removeAllModels() {
        if (this._currentModel) {
            this._scene.remove(this._currentModel);
            this._currentModel = null;
        }
    }


async loadModelAsync(url) {
   console.log(`Loading model: ${url}`);
    this.removeAllModels(); // 새 모델을 로드하기 전에 기존 모델 제거
    return new Promise((resolve, reject) => {
        const loader = new GLTFLoader();
        loader.load(url, (gltf) => {
      console.log(`Model loaded: ${url}`);
            const model = gltf.scene;
            this._scene.add(model);
            this._currentModel = model; // 현재 모델을 새 모델로 업데이트
            resolve();
        }, undefined, (error) => {
            console.error(`Error loading model: ${url}`, error);
        });
    });
}




}

let appInstance;


window.onload = function () {
    const app = new App();
   appInstance = app;
   console.log('Container size:', app._divContainer.clientWidth, app._divContainer.clientHeight);
    const container = document.getElementById('webgl-container');

    // 이벤트 위임을 사용하여 document.body에 이벤트 리스너 추가
    document.body.addEventListener('click', async (event) => {
        // .showButton 클래스를 가진 요소가 클릭되었는지 확인
        if (event.target.classList.contains('showButton')) {
            event.preventDefault(); // 기본 동작 방지
            const poseId = event.target.id; // 클릭된 요소의 ID
            const posePath = `pose/${poseId}.glb`; // GLB 파일 경로 생성

            try {
                await app.loadModelAsync(posePath); // 모델 로드
                container.style.display = "block"; // 컨테이너 표시
            } catch (error) {
                console.error("Error loading model:", error);
            }
        }
    });


   
}



$(function() {
   let downloadCount = 10; // 클릭 횟수를 추적할 변수
   $(".btn_download").click(function(e) {
      if (downloadCount <= 0) {
            alert("다운로드 횟수가 제한에 도달했습니다.");
            e.preventDefault(); // 이벤트를 중단시켜 다운로드 방지
            return; // 함수를 빠져나간다.
        }

      if (!appInstance) {
         console.error("App instance is not available.");
         return;
      }

      // 캔버스의 렌더링 상태 확인
      var canvas = appInstance._renderer.domElement;
      if (!canvas) {
         console.error("Canvas is not available.");
         return;
      }

      // 이미지로 변환 전 씬 렌더링 확인
      appInstance.render();

      // canvas를 이미지로 변환
      var dataURL = canvas.toDataURL("image/jpeg");

      // 이미지를 다운로드할 링크 생성
      var link = document.createElement("a");
      link.href = dataURL;
      link.download = 'my_model.jpg';

      // 링크를 클릭하여 다운로드
      link.click();
      
      downloadCount--; // 클릭 횟수 증가
        $('#downloadCount').text(downloadCount); // 화면에 클릭 횟수 업데이트
   });

});