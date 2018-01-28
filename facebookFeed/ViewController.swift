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
    var name: String?
    var profileImageName: String?
    var statusText: String?
    var statusImageName: String?
    var numLikes: NSNumber?
    var numComments: NSNumber?
}

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var posts = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//
//        let postMark = Post()
//        postMark.name = "Mark Zuckerberg"
//        postMark.statusText = "Meanwhile, Beast turned to the dark side."
//        postMark.profileImageName = "zuckprofile"
//
//        let postSteve = Post()
//        postSteve.name = "Steve Jobs"
//        postSteve.statusText = "Design is not just what it looks like and feels like. Design is how it works.\n\n" + "Being the richest man in the cemetery doesn't matter to me. Going to bed at night saying we've done something wonderful, that's what matters to me.\n\n" + "Sometimes when you innovate, you make mistakes. It is best to admit them quickly, and get on with improving your other innovations."
//        postSteve.profileImageName = "steve_profile"
//
//        posts.append(postMark)
//        posts.append(postSteve)
//
        
        
        let postMark = Post()
        postMark.name = "Mark Zuckerberg"
//        postMark.location = Location()
//        postMark.location?.city = "San Francisco"
//        postMark.location?.state = "CA"
        postMark.profileImageName = "zuckprofile"
        postMark.statusText = "By giving people the power to share, we're making the world more transparent."
        postMark.statusImageName = "zuckdog"
        postMark.numLikes = 400
        postMark.numComments = 123
        
        let postSteve = Post()
        postSteve.name = "Steve Jobs"
//        postSteve.location = Location()
//        postSteve.location?.city = "Cupertino"
//        postSteve.location?.state = "CA"
        postSteve.profileImageName = "steve_profile"
        postSteve.statusText = "Design is not just what it looks like and feels like. Design is how it works.\n\n" +
            "Being the richest man in the cemetery doesn't matter to me. Going to bed at night saying we've done something wonderful, that's what matters to me.\n\n" +
        "Sometimes when you innovate, you make mistakes. It is best to admit them quickly, and get on with improving your other innovations."
        postSteve.statusImageName = "steve_status"
        postSteve.numLikes = 1000
        postSteve.numComments = 55
        
        let postGandhi = Post()
        postGandhi.name = "Mahatma Gandhi"
//        postGandhi.location = Location()
//        postGandhi.location?.city = "Porbandar"
//        postGandhi.location?.state = "India"
        postGandhi.profileImageName = "gandhi_profile"
        postGandhi.statusText = "Live as if you were to die tomorrow; learn as if you were to live forever.\n" +
            "The weak can never forgive. Forgiveness is the attribute of the strong.\n" +
        "Happiness is when what you think, what you say, and what you do are in harmony."
        postGandhi.statusImageName = "gandhi_status"
        postGandhi.numLikes = 333
        postGandhi.numComments = 22
        
        
        posts.append(postMark)
        posts.append(postSteve)
        posts.append(postGandhi)
        
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
        
        if let statusText = posts[indexPath.item].statusText {
            let statusSize = CGSize(width:view.frame.width, height:1000)
            let rect = NSString(string:statusText).boundingRect(with: statusSize, options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 14)], context:nil)
            let knownHeight : CGFloat = 8 + 44 + 4 + 4 + 200 + 8 + 24 + 8 + 44
            return CGSize(width: view.frame.width, height: rect.height + knownHeight + 18)
        }
        
        let size = CGSize(width:view.frame.width, height:500)
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
            
            if let statusText = post?.statusText {
                statusTextView.text = statusText;
            }
            
            if let profileImageName = post?.profileImageName {
                profileImageView.image = UIImage(named:profileImageName)
            }
            
            if let statusImageName = post?.statusImageName {
                statusImageView.image = UIImage(named:statusImageName)
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
        textView.isScrollEnabled = false
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
        addConstraintsWithFormat(format: "V:|-8-[v0(44)]-4-[v1]-4-[v2(200)]-8-[v3(24)]-8-[v4(1)][v5(44)]|", views: profileImageView,statusTextView,statusImageView,likeCommentLabel,devideLineView,likeButton)
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










