//
//  ViewController.swift
//  MyPageControl
//
//  Created by Matt H on 2023-02-21.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    private let scrollView = UIScrollView()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        pageControl.backgroundColor = .systemTeal
        return pageControl
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        pageControl.addTarget(self,
                              action: #selector(pageControlDidChage(_:)),
                              for: .valueChanged)
        scrollView.backgroundColor = .gray
        view.addSubview(scrollView)
        view.addSubview(pageControl)
        // Do any additional setup after loading the view.
    }
    
    
    @objc private func pageControlDidChage(_ sender: UIPageControl) {
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0), animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageControl.frame = CGRect(x: 10, y: view.frame.size.height-100, width: view.frame.size.width-20, height: 70)
        
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height-100)
        
        if scrollView.subviews.count == 2 {
            configureScrollView()
        }
    }
    
    private func configureScrollView() {
        scrollView.contentSize = CGSize(width: view.frame.size.width*4, height: scrollView.frame.size.height)
        scrollView.isPagingEnabled = true
        let colors: [UIColor] = [
            .systemTeal,
            .systemBlue,
            .systemTeal,
            .systemBlue
        ]
        for x in 0..<4 {
            let page = UIView(frame: CGRect(x: CGFloat(x) * view.frame.size.width, y: 0, width: view.frame.size.width, height: scrollView.frame.size.height))
            page.backgroundColor = colors[x]
            scrollView.addSubview(page)
        }
    }

}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(Float(scrollView.contentOffset.x) / Float(scrollView.frame.size.width))
    }
}
