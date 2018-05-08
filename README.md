# unity-ParallaxHairShader
4-layer(RGBA) parallax hair shader

視差オフセットによって4層の毛を表現するシェーダ(ParallaxHair)です。   
Photoshop等でRGBAチャンネルそれぞれ異なる層の毛の不透明度を描画してテクスチャとして設定し、
レイヤー間の高さを指定すると、奥行きのある毛の層が表現できます。

影シェーダ(ParallaxHair_Shadow)に同じテクスチャを指定すれば、毛の影を乗算で載せることが出来ます。  
サンプルでは同じメッシュに複数のマテリアルを(Unity上で）割り当てることで実現しています。

以下サンプルシーンの画像です。  
平面画像では奥行きがあることが分かりにくいですが、カメラ移動やVRなど視差が発生する場合は効果が高いです。  
![サンプル](https://user-images.githubusercontent.com/39085780/39757591-47d9fcec-5308-11e8-9f91-45c8f8a4466f.png)
