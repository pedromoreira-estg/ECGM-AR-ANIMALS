﻿/** * ECGM fARm - An Augmented Reality FARM * Application originally developed for Mostra IPVC'12 16,17 May 2012 * * -------------------------------------------------------------------------------- * Copyright (C)2012 Pedro Moreira, Helder Vieira, Sandra Rodet , Fábio Moreira & Ana Gabi Veloso * Engenharia da Computação Gráfica e Multimédia * Escola Superior de Tecnologia e Gestão * Instituto Politécnico de Viana do Castelo * Av. do AtlANtico s/n 4900-348 Viana do Castelo, Portugal * pmoreira[at]estg[dot]ipvc[dot]pt  * * This program is free software: you can redistribute it and/or modify * it under the terms of the GNU General Public License as published by * the Free Software Foundation, either version 3 of the License, or * (at your option) any later version. *  * This program is distributed in the hope that it will be useful, * but WITHOUT ANY WARRANTY; without even the implied warranty of * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the * GNU General Public License for more details. * * You should have received a copy of the GNU General Public License * along with this program.  If not, see <http://www.gnu.org/licenses/>. *  *//** * FLARToolKit example - Simple cube PV3D * -------------------------------------------------------------------------------- * Copyright (C)2010 rokubou * * This program is free software: you can redistribute it and/or modify * it under the terms of the GNU General Public License as published by * the Free Software Foundation, either version 3 of the License, or * (at your option) any later version. *  * This program is distributed in the hope that it will be useful, * but WITHOUT ANY WARRANTY; without even the implied warranty of * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the * GNU General Public License for more details. * * You should have received a copy of the GNU General Public License * along with this program.  If not, see <http://www.gnu.org/licenses/>. *  * For further information please contact. *	http://www.libspark.org/wiki/saqoosha/FLARToolKit *  * Contributor(s) *  rokubou at The Sixwish project *  * comment *  今回のサンプルは Model 2 に限定している。 */  /** * FLARToolKit * "Animais Realidade Aumentada" * Tecnologias Multimédia * ECGM * -------------------------------------------------------------------------------- * Sandra Rodet, Gabi Veloso, Helder Vieira, Fábio Moreira */package examples{	import flash.display.Bitmap;	import flash.display.BitmapData;	import flash.display.PixelSnapping;	import flash.display.Sprite;	import flash.events.Event;	import flash.media.Camera;	import flash.media.Video;	import flash.net.URLLoaderDataFormat;	import flash.utils.ByteArray;	import flash.text.TextField;		import away3d.containers.ObjectContainer3D;	import away3d.containers.Scene3D;	import away3d.containers.View3D;	import away3d.core.utils.Cast;	import away3d.events.Loader3DEvent;	import away3d.materials.WireframeMaterial;	import away3d.materials.BitmapFileMaterial;	import away3d.primitives.Cube;	import away3d.primitives.Plane;	import away3d.primitives.TextField3D;	import away3d.loaders.Max3DS;	import away3d.loaders.LoaderCube;		import jp.nyatla.as3utils.NyMultiFileLoader;		import org.libspark.flartoolkit.core.FLARCode;	import org.libspark.flartoolkit.core.analyzer.raster.threshold.FLARRasterThresholdAnalyzer_SlidePTile;	import org.libspark.flartoolkit.core.param.FLARParam;	import org.libspark.flartoolkit.core.raster.rgb.FLARRgbRaster_BitmapData;	import org.libspark.flartoolkit.core.transmat.FLARTransMatResult;	import org.libspark.flartoolkit.detector.idmarker.FLARMultiIdMarkerDetector;	import org.libspark.flartoolkit.detector.idmarker.data.FLARIdMarkerData;	import org.libspark.flartoolkit.support.away3d.FLARCamera3D;	import org.libspark.flartoolkit.support.away3d.FLARBaseNode;	public class FLARTK_Example_Multiple_ID1_Away3D extends Sprite 	{		[Embed(source='../../resources/model/1.jpg')]    				public var tex1:Class;					 		[Embed(source='../../resources/model/2.jpg')]    				public var tex2:Class;		[Embed(source='../../resources/model/3.jpg')]    				public var tex3:Class;		[Embed(source='../../resources/model/4.jpg')]    				public var tex4:Class;		[Embed(source='../../resources/model/5.jpg')]    				public var tex5:Class;		[Embed(source='../../resources/model/6.jpg')]    				public var tex6:Class;		[Embed(source='../../resources/model/7.jpg')]    				public var tex7:Class;		[Embed(source='../../resources/model/8.jpg')]    				public var tex8:Class;		[Embed(source='../../resources/model/9.jpg')]    				public var tex9:Class;		[Embed(source='../../resources/model/10.jpg')]    				public var tex10:Class;		[Embed(source='../../resources/model/11.jpg')]    				public var tex11:Class;		[Embed(source='../../resources/model/12.jpg')]    				public var tex12:Class;		[Embed(source='../../resources/model/13.jpg')]    				public var tex13:Class;		[Embed(source='../../resources/model/14.jpg')]    				public var tex14:Class;		[Embed(source='../../resources/model/15.jpg')]    				public var tex15:Class;		[Embed(source='../../resources/model/16.jpg')]    				public var tex16:Class;		[Embed(source='../../resources/model/17.jpg')]    				public var tex17:Class;		[Embed(source='../../resources/model/18.jpg')]    				public var tex18:Class;		[Embed(source='../../resources/model/19.jpg')]    				public var tex19:Class;		[Embed(source='../../resources/model/20.jpg')]    				public var tex20:Class;				[Embed(source='../../resources/model/245.jpg')]    				public var tex245:Class;				var _NMODELS = 20;		var _NMARKERS = 120;		var _STAFFID = 245;						protected var canvasWidth:int;		protected var canvasHeight:int;		protected var captureWidth:int;		protected var captureHeight:int;		protected var codeWidth:int;				protected var cameraParamFile:String;				protected var cameraParam:FLARParam;				protected var markerPatternCode:FLARCode;		protected var webCamera:Camera;				protected var video:Video;				private var capture:Bitmap;		private var raster:FLARRgbRaster_BitmapData;				private var detector:FLARMultiIdMarkerDetector;				private var _threshold:int = 110;				private var _threshold_detect:FLARRasterThresholdAnalyzer_SlidePTile;				protected var markerNode:FLARBaseNode;				protected var aaa :BitmapFileMaterial;		//Away 3D		protected var view3D:View3D;		protected var scene3d:Scene3D;		protected var camera3d:FLARCamera3D;				//modelos carregados		var allmodels : Array = new Array();		/* **************		 * Construtor		 ************** */		public function FLARTK_Example_Multiple_ID1_Away3D():void 		{			initmodels();														// Carregar modelos no flash			init();																// Iniciar camara		}				/* ***************************		 * Carregar modelos no flash *		 *************************** */		private function initmodels()		{			var _container:ObjectContainer3D;									// Contentor Obj 3D			var _max3ds;														// Objecto tipo Max3DS			var _loader;														// LoaderCube									// Carregar modelos 3D			for(var i=1; i < _NMODELS + 1; i++)			{				_container = new ObjectContainer3D();							// Novo Contentor								_max3ds = new Max3DS();											// Novo Objecto tipo Max3DS (3D Studio Max)				_max3ds.centerMeshes = true;									// Centrar modelo								_max3ds.material = Cast.material(new this['tex'+i]);			// Agregar material ao modelo 3D								// Carregar modelo 3D				_loader = new LoaderCube();				_loader.addOnSuccess(onSuccess);				_loader.loadGeometry("../resources/model/"+i+".3DS", _max3ds);				_loader.y = 80;								_container.addChild(_loader);				allmodels[i] = _container;			}						// Carregar modelo STAFF			_container = new ObjectContainer3D();								// Novo Contentor						_max3ds = new Max3DS();												// Novo Objecto tipo Max3DS (3D Studio Max)	  		_max3ds.centerMeshes = true;										// Centrar modelo	    				_max3ds.material = Cast.material(new this['tex'+_STAFFID]);			// Agregar material ao modelo 3D						// Carregar modelo 3D			_loader = new LoaderCube();	    	_loader.addOnSuccess(onSuccess);	    	_loader.loadGeometry("../resources/model/"+_STAFFID+".3DS", _max3ds);						_container.addChild(_loader);			allmodels[_STAFFID] = _container;		}						/* ******************************		 * Iniciar definições de camara *		 ****************************** */		private function init():void		{			this.captureWidth  = 320;  // 320			this.captureHeight = 180;  //180 240						this.canvasWidth = 640			this.canvasHeight = 360; //360 480						this.codeWidth = 80;									// Selecção dos parâmetros da webcam			// 4:3			//this.cameraParamFile = '../resources/Data/camera_para.dat';			// 16：9			this.cameraParamFile = '../resources/Data/camera_para_16x9.dat';						this.paramLoad();		}				/* *********************************************************		 * Carregar ficheiro de parâmetros da webcam para o FLARTK *		 ********************************************************* */		private function paramLoad():void		{			var mf:NyMultiFileLoader = new NyMultiFileLoader();						mf.addTarget(						this.cameraParamFile,						URLLoaderDataFormat.BINARY,						function(data:ByteArray):void						{							cameraParam = new FLARParam();							cameraParam.loadARParam(data);							cameraParam.changeScreenSize(captureWidth, captureHeight);						}						);						mf.addEventListener(Event.COMPLETE, initialization);			mf.multiLoad();						return;		}				/* ************************************		 * Iniciar sistema                    *		 ************************************ */		private function initialization(e:Event): void		{			this.removeEventListener(Event.COMPLETE, initialization);						// Setup camera			this.webCamera = Camera.getCamera();			if (!this.webCamera)				throw new Error('No webcam!!!!');						this.webCamera.setMode(this.captureWidth, this.captureHeight, 30);			this.video = new Video(this.captureWidth, this.captureHeight);			this.video.attachCamera(this.webCamera);						// setup ARToolkit			this.capture = new Bitmap(									new BitmapData(this.captureWidth, this.captureHeight, false, 0),									PixelSnapping.AUTO,									true									);			this.capture.width = this.canvasWidth;			this.capture.height = this.canvasHeight;						// mirror the capture			this.capture.scaleX *= -1;			this.capture.x += canvasWidth;						this.raster = new FLARRgbRaster_BitmapData(this.capture.bitmapData);			this.addChild(this.capture);						// setup Multi marker detector			this.detector = new FLARMultiIdMarkerDetector( this.cameraParam,	this.codeWidth);			this.detector.setContinueMode(true);			this._threshold_detect=new FLARRasterThresholdAnalyzer_SlidePTile(15,4);						dispatchEvent(new Event(Event.INIT));						this.supportLibsInit();						this.start();		}				/* ************************************		 * Iniciar bibliotecas de suporte     *		 ************************************ */		protected function supportLibsInit(): void		{			this.scene3d = new Scene3D();			this.markerNode = new FLARBaseNode();			this.scene3d.addChild(this.markerNode);			this.camera3d = new FLARCamera3D();			this.camera3d.setParam(this.cameraParam);						this.view3D = new View3D({scene:this.scene3d, camera:camera3d});			this.view3D.x = this.captureWidth -6;			this.view3D.y = this.captureHeight;						// flip the viewport			this.view3D.scaleX *= -1;						this.addChild(this.view3D);			}				/* ***************************		 * 3D ID                     *		 *************************** */		var max3ds:Max3DS;		var loader:LoaderCube;   		var model:ObjectContainer3D;		//material objects		var materialArray:Array;		var materialIndex:int = 0;				// Delayer		var framesToDelay:int = 5;			/* *******************************************************											 * Este framesToDelay indica o número de frames, que os  *											 * modelos devem aguardar, antes de serem escondidos, de *											 * forma a evitar que ocorra flicker.                    *											 ******************************************************* */						protected function createObject(_nyId:int):ObjectContainer3D		{			var mid = (_nyId % _NMODELS) + 1;						if(_nyId == _STAFFID)				return allmodels[_STAFFID];			else				return allmodels[mid];		}				protected var markerList:Vector.<MarkerData>;		protected var markerListIndex:Vector.<int>;		/* *******************************************		 * Em caso de ficheiro carregado com sucesso *		 ******************************************* */		function onSuccess(e:Loader3DEvent):void		{			/* ************			 * Fazer nada *			 ************ */		}				/* ********************************		 * Iniciar animação               *		 ******************************** */		protected function start():void		{			//lista de marcadores			this.markerList = new Vector.<MarkerData>();			//lista de indices			this.markerListIndex = new Vector.<int>();						this.addEventListener(Event.ENTER_FRAME, this.run);		}				/* ********************************		 * Correr a animação              *		 ******************************** */		public function run(e:Event):void		{			// captura frames video			this.capture.bitmapData.draw(this.video);						// Marcadores detectados			var detectedNumber:int = 0;						try			{				// Procura o número de marcadores detectados				detectedNumber = this.detector.detectMarkerLite(this.raster, this._threshold);			}			catch (e:Error)			{				;//trace("ERRO!");  Fazer nada para poupar desempenho			}						// Lista de marcadores			var _markerList:Vector.<MarkerData> = new Vector.<MarkerData>();						//Itera os marcadores detectados e coloca os modelos correspondentes na markerlist			for(i = 0; i < detectedNumber; i++)			{				var _markerData:MarkerData = new MarkerData(this.detector.getIdMarkerData(i).model, this.detector.getARCodeIndex(i));				this.detector.getTransformMatrix(i, _markerData.resultMat);				// signal if is being detected				_markerData.isDetect = true;								// insert it into a marker list				_markerList.push(_markerData);			}						/* *******************************************************			 * Incrementa o delayer que controla quando os modelos   *			 * são visíveis ou invisíveis, escondendo-os quando      *			 * ultrapassa o número limite de frames (framesToDelay). *			 ******************************************************* */			for(i = 0; i < this.markerList.length; i++)				if(this.markerList[i].delayer > this.framesToDelay)					this.markerList[i].flarNode.visible = false;				else					this.markerList[i].delayer++;						// Verifica se a lista de marcadores se encontra vazia			if (_markerList.length != 0)			{				var _hitIndex:int = -1;								/* *******************************************************				 * Percorre a lista de marcadores para identificar quais *				 * destes estão visíveis.                                *				 ******************************************************* */				for (var i = 0; i < _markerList.length; i++)				{					// see if they were already visible					_hitIndex = this.markerListIndex.indexOf(_markerList[i].markerId);										// Verifica se o marcador já existe em memória					if (_hitIndex != -1)					{						this.markerList[_hitIndex].setTransMat(_markerList[i].resultMat);						this.markerList[_hitIndex].flarNode.visible = true;						this.markerList[_hitIndex].delayer = 0;					}					// Se não existir:					else					{						_markerList[i].flarNode = new FLARBaseNode();						_markerList[i].flarNode.addChild(this.createObject(_markerList[i].markerId));												_markerList[i].flarNode.visible = true;						_markerList[i].delayer = 0;												this.markerList.push(_markerList[i].clone());						var lastIndex:int = this.markerList.length-1;						this.markerListIndex.push(_markerList[i].markerId);												this.scene3d.addChild(this.markerList[lastIndex].flarNode);					}				}			}			// Caso a lista de marcadores esteja vazia			else			{				var th:int = this._threshold_detect.analyzeRaster(this.raster);				this._threshold = (this._threshold+th)/2;								// Forçar update sempre que não existam marcadores visíveis				this.view3D.forceUpdate = true;			}						// Fazer o render da cena			this.view3D.render();		}	}}import org.libspark.flartoolkit.detector.idmarker.data.FLARIdMarkerData;import org.libspark.flartoolkit.core.transmat.FLARTransMatResult;import org.libspark.flartoolkit.support.away3d.FLARBaseNode;import away3d.containers.ObjectContainer3D;// Class com a informação dos marcadoresinternal class MarkerData{	public var IdModel:int;	public var markerId:int;	public var resultMat:FLARTransMatResult;	public var flarNode:FLARBaseNode;	public var isDetect:Boolean = false;	public var delayer:int;		// Construtor	public function MarkerData(_model:int, _markerId:int)	{		this.IdModel = _model;		this.markerId = _markerId;		this.resultMat = new FLARTransMatResult();		this.delayer = 0;	}		// Definir transformações (Rotação, Translação e Escala)	public function setTransMat(_transMat:FLARTransMatResult):void	{		this.resultMat = _transMat;		this.flarNode.setTransformMatrix(_transMat);	}		// Duplicar marcador	public function clone():MarkerData	{		var newObject:MarkerData = new MarkerData(this.IdModel, this.markerId);		newObject.resultMat = this.resultMat;		newObject.flarNode = this.flarNode;		newObject.isDetect = this.isDetect;				return newObject;	}}