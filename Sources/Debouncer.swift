//
//  Copyright (c) 2016 Algolia
//  http://www.algolia.com/
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation


/// Merges multiple calls into a single one.
///
/// The debouncer works by delaying every call by a given delay; if another call happens before the delay is expired,
/// the timer is reset and the first call is ignored. When the delay expires, the last call is fired.
///
@objc public class Debouncer: NSObject {
    public typealias DebouncedBlock = () -> ()
    
    @objc public let delay: NSTimeInterval
    private var block: DebouncedBlock!
    private var timer: NSTimer?
    
    /// Init a debouncer with a given delay.
    ///
    /// - parameter delay: The delay by which to debounce calls.
    ///
    @objc public init(delay: NSTimeInterval) {
        self.delay = delay
    }
    
    deinit {
        timer?.invalidate()
        block = nil
    }
    
    /// Register another call.
    /// It will be fired after the delay has expired, unless another call has been made before that.
    ///
    /// - parameter block: The call to debounce.
    ///
    @objc public func call(block: DebouncedBlock) {
        self.block = block
        timer?.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(delay, target: self, selector: #selector(self.runBlock), userInfo: nil, repeats: false)
    }
    
    @objc private func runBlock() {
        block()
        timer = nil
        block = nil
    }
}
