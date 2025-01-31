//
//  MyImagePicker.swift
//  UIViewControllerDemo
//
//  Created by 강보현 on 1/23/25.
//

import SwiftUI

struct MyImagePicker: UIViewControllerRepresentable {
    
    @Binding var imagePickerVisiable: Bool
    @Binding var selectedImage: Image?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: MyImagePicker
        init(_ parent: MyImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ pickeer: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = Image(uiImage: image)
            }
            parent.imagePickerVisiable = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.imagePickerVisiable = false
        }
    }
    
}

#Preview {
    MyImagePicker(imagePickerVisiable: .constant(false), selectedImage: .constant(nil))
}
