//
//  ViewController.swift
//  facebookFeed
//
//  Created by Prashant Dwivedi on 1/25/18.
//  Copyright © 2018 Prashant Dwivedi. All rights reserved.
//

import UIKit

let cellId = "cellId"

class Post  {
    var name : String?
}

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var posts = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let postMark = Post()
        postMark.name = "Mark Zuckerberg"
        
        let postSteve = Post()
        postSteve.name = "Steve Jobs"
        
        posts.append(postMark)
        posts.append(postSteve)
        
        navigationItem.title = "Facebook Feed"
        
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        
        feedCell.post = posts[indexPath.item]
        return feedCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width:view.frame.width, height:400)
//        print(size)
        return size
    }
}


class FeedCell: UICollectionViewCell {
    
    var post: Post?{
        didSet{
            
            if let name = post?.name {
            let attributedText = NSMutableAttributedString(string: name, attributes:[NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14)])
            attributedText.append(NSAttributedString(string:"\nDecember 18  •  San Francisco  • ", attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor:UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1)]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
            
            let attachment = NSTextAttachment()
            attachment.image = UIImage(named:"globe_small")
            attachment.bounds = CGRect(x:0, y: -2, width: 12, height: 12)
            attributedText.append(NSAttributedString(attachment:attachment))
            
            nameLabel.attributedText = attributedText
            }
        }
    }
    
    override init(frame :CGRect){
        super.init(frame:frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        
        
        
        return label
    }()
    
    let statusTextView:UITextView = {
        let textView = UITextView()
        textView.text = "Meanwhile, Beast turned to the dark side."
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
    }()
    
    let likeCommentLabel : UILabel = {
       let label = UILabel ()
        label.text = "488 Likes   10.7k Comments"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 151, green: 161, blue: 171)
        return label
    }()
    
    let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"zuckprofile")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    let statusImageView :UIImageView = {
        let imageView = UIImageView ()
        imageView.image = UIImage(named:"zuckdog")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let likeButton : UIButton = buttonForTitle(title: "Like", imageNamed: "like")
    let commentButton : UIButton = buttonForTitle(title: "Comment", imageNamed: "comment")
    let shareButton : UIButton = buttonForTitle(title: "Share", imageNamed: "share")
    
    let devideLineView : UIView = {
        let view = UIView ()
        view.backgroundColor = UIColor.rgb(red: 226, green: 228, blue: 232)
        return view
    }()
    
    static func buttonForTitle(title:String, imageNamed:String) -> UIButton {
        let button = UIButton ()
        button.setTitle(title, for: UIControlState.normal)
        button.setTitleColor(UIColor.rgb(red: 143, green: 150, blue: 163), for: UIControlState.normal)
        
        button.setImage(UIImage(named:imageNamed), for: UIControlState.normal)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
        
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        return button
    }
    
    func setupViews() {
        backgroundColor = UIColor.white
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likeCommentLabel)
        addSubview(devideLineView)
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, nameLabel)
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: statusTextView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: statusImageView)
        addConstraintsWithFormat(format: "H:|-12-[v0]|", views: likeCommentLabel)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: devideLineView)
        addConstraintsWithFormat(format: "H:|[v0(v2)][v1(v2)][v2]|", views: likeButton, commentButton, shareButton)
        addConstraintsWithFormat(format: "V:|-12-[v0]", views: nameLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0(44)]-4-[v1(30)]-4-[v2]-8-[v3(24)]-8-[v4(1)][v5(44)]|", views: profileImageView,statusTextView,statusImageView,likeCommentLabel,devideLineView,likeButton)
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: commentButton)
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: shareButton)
        
       
    }
}

extension UIColor {
    static func rgb(red:CGFloat, green:CGFloat, blue:CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    
    func addConstraintsWithFormat(format: String, views:UIView...) {
        var viewsDictionary = [String:UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}










