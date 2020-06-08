//
//  String+Emoji.swift
//  SwiftMore
//
//  Created by zhoujie on 2020/6/3.
//  Copyright © 2020 精灵要跳舞. All rights reserved.
//

import Foundation
extension Character {
    /// 简单的emoji是一个标量，以emoji的形式呈现给用户
    var isSimpleEmoji: Bool {
        guard let firstProperties = unicodeScalars.first?.properties else {
            return false
        }
        if #available(iOS 10.2, *) {
            return unicodeScalars.count == 1 &&
                (firstProperties.isEmojiPresentation ||
                    firstProperties.generalCategory == .otherSymbol)
        } else {
            return unicodeScalars.count == 1 && firstProperties.generalCategory == .otherSymbol
        }
    }

    /// 检查标量是否将合并到emoji中
    var isCombinedIntoEmoji: Bool {
        return unicodeScalars.count > 1 &&
            unicodeScalars.contains { $0.properties.isJoinControl || $0.properties.isVariationSelector }
    }

    /// 是否为emoji表情
    /// - Note: http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
    var isEmoji:Bool {
        return isSimpleEmoji || isCombinedIntoEmoji
    }
}

extension String {
    /// 是否为单个emoji表情
    var isSingleEmoji: Bool {
        return count == 1 && containsEmoji
    }

    /// 包含emoji表情
    var containsEmoji: Bool {
        return contains{$0.isEmoji}
    }

    /// 只包含emoji表情
    var containsOnlyEmoji: Bool {
        return !isEmpty && !contains{!$0.isEmoji}
    }

    /// 提取emoji表情字符串
    var emojiString: String {
        return emojis.map{String($0) }.reduce("",+)
    }

    /// 提取emoji表情数组
    var emojis: [Character] {
        return filter{ $0.isEmoji}
    }

    /// 提取单元编码标量
    var emojiScalars: [UnicodeScalar] {
        return filter{ $0.isEmoji}.flatMap{ $0.unicodeScalars}
    }
}
