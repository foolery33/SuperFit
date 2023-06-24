//
//  ImageViewController.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 24.06.2023.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    private let viewModel: ImageViewModel
    
    init(viewModel: ImageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupImageView()
        setupBackArrowButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        updateZoomScale()
    }
    
    private lazy var scrollView: UIScrollView = {
        let myScrollView = UIScrollView()
        myScrollView.delegate = self
        myScrollView.minimumZoomScale = 1.0
        myScrollView.maximumZoomScale = 5.0
        myScrollView.showsVerticalScrollIndicator = false
        myScrollView.showsHorizontalScrollIndicator = false
        myScrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return myScrollView
    }()
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    private lazy var imageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.image = image
        myImageView.contentMode = .scaleAspectFit
        myImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        myImageView.isUserInteractionEnabled = true
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        myImageView.addGestureRecognizer(doubleTapGesture)
        return myImageView
    }()
    private func setupImageView() {
        scrollView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    private lazy var image: UIImage = {
        let myImage = UIImage(data: viewModel.imageData ?? Data())
        return myImage ?? R.image.myProgress1()!
    }()
    
    private func updateZoomScale() {
        let scrollViewSize = scrollView.bounds.size
        let imageSize = image.size
        let widthScale = scrollViewSize.width / imageSize.width
        let heightScale = scrollViewSize.height / imageSize.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }
    
    // MARK: - BackArrowButton setup
    private lazy var backArrowButton: UIButton = {
        let myButton = UIButton()
        myButton.setImage(R.image.backwardArrow(), for: .normal)
        myButton.addTarget(self, action: #selector(onBackArrowButtonTapped), for: .touchUpInside)
        myButton.tintColor = R.color.white()
        return myButton
    }()
    @objc private func onBackArrowButtonTapped() {
        viewModel.goBackToImageListScreen()
    }
    private func setupBackArrowButton() {
        view.addSubview(backArrowButton)
        backArrowButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(9)
        }
    }
    
    @objc private func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        if scrollView.zoomScale == scrollView.minimumZoomScale {
            // Приближение в точку, по которой было выполнено двойное нажатие
            let pointInView = gesture.location(in: imageView)
            let newZoomScale = scrollView.maximumZoomScale / 2
            let scrollViewSize = scrollView.bounds.size
            let w = scrollViewSize.width / newZoomScale
            let h = scrollViewSize.height / newZoomScale
            let x = pointInView.x - (w / 2.0)
            let y = pointInView.y - (h / 2.0)
            let rectToZoomTo = CGRect(x: x, y: y, width: w, height: h)
            
            scrollView.zoom(to: rectToZoomTo, animated: true)
        } else {
            // Возврат к минимальному зуму
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
