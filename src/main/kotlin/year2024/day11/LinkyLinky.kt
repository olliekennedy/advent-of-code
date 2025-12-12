package year2024.day11

fun main() {
    creatingAndLinkingNodes()
    push()
    append()
    nodeAt()
    insert()
    pop()
    removeLast()
    removeAfter()
}

private fun creatingAndLinkingNodes() {
    val node3 = Node(value = 3)
    val node2 = Node(value = 2, next = node3)
    val node1 = Node(value = 1, next = node2)
    
    println("creatingAndLinkingNodes:")
    println(node1)
}

private fun push() {
    val list = LinkedList<Int>()
    list.push(3).push(2).push(1)

    println("push:")
    println(list)
}

private fun append() {
    val list = LinkedList<Int>()
    list.append(1).append(2).append(3)

    println("append:")
    println(list)
}

private fun nodeAt() {
    val list = LinkedList<Int>()
    list.append(1).append(2).append(3)

    val summin = list.nodeAt(1)

    println("nodeAt:")
    println(summin)
}

private fun insert() {
    val list = LinkedList<Int>()
    list.append(1).append(2).append(3)

    val newList = list.insert(2024, list.nodeAt(1)!!)

    println("insert:")
    println(newList)
}

private fun pop() {
    val list = LinkedList<Int>()
    list.append(1).append(2).append(3)

    val newList = list.pop()

    println("pop:")
    println(newList)

    val emptyList = LinkedList<Int>()

    val poppedList = emptyList.pop()

    println("empty pop:")
    println(poppedList)
}

private fun removeLast() {
    val list = LinkedList<Int>()
    list.append(1).append(2).append(3)

    val newList = list.removeLast()

    println("removeLast:")
    println(newList)

    val emptyList = LinkedList<Int>()

    val someList = emptyList.removeLast()

    println("empty removeLast:")
    println(someList)
}

private fun removeAfter() {
    val list = LinkedList<Int>()
    list.append(1).append(2).append(3)

    val newList = list.removeAfter(list.nodeAt(0)!!)

    println("removeAfter:")
    println(newList)
}

data class Node<T>(var value: T, var next: Node<T>? = null) {
    override fun toString(): String {
        return if (next != null) {
            "$value -> ${next.toString()}"
        } else {
            "$value"
        }
    }

    fun evenLength(): Boolean {
        return this.value.toString().length % 2 == 0
    }
}

class LinkedList<T> {

    private var head: Node<T>? = null
    private var tail: Node<T>? = null
    var size = 0

    fun isEmpty(): Boolean {
        return size == 0
    }

    override fun toString(): String {
        if (isEmpty()) {
            return "Empty list"
        } else {
            return head.toString()
        }
    }

    fun push(value: T): LinkedList<T> {
        head = Node(value = value, next = head)
        if (tail == null) {
            tail = head
        }
        size++

        return this
    }

    fun append(value: T): LinkedList<T> {
        if (isEmpty()) {
            push(value)
            return this
        }

        tail!!.next = Node(value = value)

        tail = tail!!.next

        size++

        return this
    }

    fun nodeAt(index: Int): Node<T>? {
        var currentNode: Node<T>? = head
        var whereAmI = 0
        while (currentNode != null && whereAmI < index) {
            currentNode = currentNode.next
            whereAmI++
        }

        return currentNode
    }

    fun insert(value: T, afterNode: Node<T>): LinkedList<T> {
        if (afterNode == tail) {
            append(value)
            return this
        }

        val newNode = Node(value = value, next = afterNode.next)
        afterNode.next = newNode
        size++
        return this
    }

    fun pop(): LinkedList<T> {
        if (!isEmpty()) size--

        head = head?.next
        if (isEmpty()) {
            tail = null
        }

        return this
    }

    fun removeLast(): LinkedList<T> {
        if (isEmpty()) {
            return this
        }

        if (size == 1) {
            return pop()
        }

        val secondToLastNode = nodeAt(size - 2)
        secondToLastNode?.next = null
        tail = secondToLastNode

        size--

        return this
    }

    fun removeAfter(beforeNode: Node<T>): LinkedList<T> {
        val nodeToRemove = beforeNode.next ?: return this

        if (nodeToRemove == tail) {
            tail = beforeNode
        }

        size--

        beforeNode.next = nodeToRemove.next

        return this
    }
}

