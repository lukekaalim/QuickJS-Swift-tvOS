//
//  JSInterop.swift
//  
//
//  Created by Luke Kaalim on 26/12/2022.
//

import Foundation

public protocol JSInteroperable {
    associatedtype JSType;
    
    static func createFromJS(_ value: JSValue) -> JSType;
    func convertToJS(_ context: JSContext) -> JSValue;
}

extension String: JSInteroperable {
    public static func createFromJS(_ value: JSValue) -> String {
        return value.string!;
    }
    
    public typealias JSType = String;
    
    public func convertToJS(_ context: JSContext) -> JSValue {
        return self.jsValue(context.core);
    }
}
extension Double: JSInteroperable {
    public static func createFromJS(_ value: JSValue) -> Double {
        return value.double!;
    }
    
    public typealias JSType = Double;
    
    public func convertToJS(_ context: JSContext) -> JSValue {
        return self.jsValue(context.core);
    }
}
extension Bool: JSInteroperable {
    public static func createFromJS(_ value: JSValue) -> Bool {
        return value.bool!;
    }
    
    public typealias JSType = Bool;
    
    public func convertToJS(_ context: JSContext) -> JSValue {
        return self.jsValue(context.core);
    }
}

extension Array: JSInteroperable where Element: JSInteroperable {
    public typealias JSType = Array<Element.JSType>;
    
    public static func createFromJS(_ value: JSValue) -> Array<Element.JSType> {
        let jsArray = value.array!;
        var swiftArray: [Element.JSType] = [];
        for index in 0...jsArray.length {
            let element: Element.JSType = Element.createFromJS(jsArray.getIndex(index));
            swiftArray.append(element);
        }
        return swiftArray;
    }
    
    public func convertToJS(_ context: JSContext) -> JSValue {
        let array = context.createArray();
        for (index, element) in self.enumerated() {
            array.setIndex(index, element.convertToJS(context))
        }
        return array;
    }
}

/*

struct Example: JSInteroperable {
    let state: Int;
    
    static func createFromJS(_ value: JSValue) -> Example {
        Example(state: value.object!.getProperty("state").int!);
    }
    
    func convertToJS(_ context: JSContext) -> JSValue {
        let obj = context.createObject()
        obj.setProperty("state", Double(state).convertToJS(context));
        return obj;
    }
    
    typealias JSType = Example
}

func test(context: JSContext) {
    let a: JSValue = [0, 1, 2].convertToJS(context);
    let b: [Double] = [Double].createFromJS(a);
    let c: [Int] = [Example].createFromJS(a).map { e in e.state }
    let d: [[Double]] = [[Double]].createFromJS(a);
}

*/
