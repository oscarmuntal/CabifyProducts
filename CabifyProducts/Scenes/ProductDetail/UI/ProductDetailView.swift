//
//  ProductDetailView.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import UIKit

class ProductDetailView: UIViewController, CreatableView {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var numberOfItems: UILabel!
    @IBAction func substract(_ sender: Any) {
        presenter?.substractOne()
    }
    @IBAction func add(_ sender: Any) {
        presenter?.addOne()
    }
    @IBOutlet weak var addToBasketButton: UIButton!
    @IBAction func addToBasket(_ sender: Any) {
        print("to basket")
    }
    @IBAction func close(_ sender: Any) {
        presenter?.closeModalScreen(self)
    }
    
    public var presenter: ProductDetailPresenterContract?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.view = self
    }
    
}

extension ProductDetailView: ProductDetailViewContract {
    func setQuantity(with quantity: Int) {
        numberOfItems.text = "\(quantity)"
        guard let presenter = presenter else { return }
        setBasketButton(with: presenter)
    }
    
    func configure(with productViewModel: ProductViewModel) {
        productImageView.image = UIImage(named: productViewModel.imageName)
        name.text = productViewModel.name
        price.text = "\(productViewModel.price) €"
        productDescription.text = productViewModel.promotion
        guard let presenter = presenter else { return }
        setBasketButton(with: presenter)
    }
}

private extension ProductDetailView {
    func setBasketButton(with presenter: ProductDetailPresenterContract) {
        let title = "Add \(presenter.quantity) to basket · \(presenter.totalPrice) €"
        addToBasketButton.setTitle(title, for: .normal)
    }
}
