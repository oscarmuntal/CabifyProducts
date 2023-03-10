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
        presenter?.postSelectedItems()
        presenter?.closeModalScreen(self)
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
    func configure(with productViewModel: ProductViewModel) {
        productImageView.image = UIImage(named: productViewModel.imageName)
        name.text = productViewModel.name
        price.text = "\(productViewModel.price) €"
        productDescription.text = productViewModel.detail
        numberOfItems.text = "\(productViewModel.quantity)"
        guard let presenter = presenter else { return }
        setBasketButtonTitle(with: presenter, viewModel: productViewModel)
    }
}

private extension ProductDetailView {
    func setBasketButtonTitle(with presenter: ProductDetailPresenterContract, viewModel: ProductViewModel) {
        let title = presenter.quantity > 0 ?
                    "Add \(presenter.quantity) to basket · \(viewModel.finalPrice) €" :
                    "Remove this item from the basket"
        addToBasketButton.setTitle(title, for: .normal)
    }
}
