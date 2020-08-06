//
//  SecondViewController.swift
//  Mole Scan App
//
//  Created by Vidushi Meel on 7/14/20.
//

import UIKit
import CoreML
import Vision


class SecondViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var imagePicker = UIImagePickerController()
    @IBOutlet weak var uiImageView: UIImageView!
    @IBAction func takePhoto(_ sender: UIButton) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    @IBOutlet weak var textView: UITextView!
    @IBAction func chooseImage(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
          super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        self.textView.text = ""
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        uiImageView.image = info[.originalImage] as? UIImage
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            uiImageView.image = userPickedImage
            guard let ciImage = CIImage(image: userPickedImage) else {
                fatalError("Cannot convert to CIImage.")
            }
            detect(image: ciImage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func detect(image: CIImage) {
           guard let model = try? VNCoreMLModel(for: moleScanDetectorModel_1().model) else {
               fatalError("Loading CoreML Model Failed.")
           }
           let request = VNCoreMLRequest(model: model) { (request, error) in
               guard let results = request.results as? [VNClassificationObservation] else {
                   fatalError("Model failed to process image.")
               }
               if let firstResult = results.first {
                   
                if firstResult.identifier == "benign" {
                    self.textView.text = "RESULT: The inputted image shows a " + firstResult.identifier + " mole."
                    self.textView.textColor = UIColor.green

                     print ("RESULT: The inputted image shows a " + firstResult.identifier + " mole.")
                }
                else {
                    self.textView.text = "RESULT: The inputted image shows a " + firstResult.identifier + " mole."
                    self.textView.textColor = UIColor.red

                     print ("RESULT: The inputted image shows a " + firstResult.identifier + " mole.")
                }
                print ("RESULT: The inputted image shows a " + firstResult.identifier + " mole.")
               }
           }
           let handler = VNImageRequestHandler(ciImage: image)
           do {
               try handler.perform([request])
           }
           catch {
               print(error)
           }
       }
}
