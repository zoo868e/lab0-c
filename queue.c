#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "strnatcmp.h"


#include "harness.h"
#include "queue.h"

/*
 * Create empty queue.
 * Return NULL if could not allocate space.
 */
queue_t *q_new()
{
    queue_t *q = malloc(sizeof(queue_t));
    /* TODO: What if malloc returned NULL? */
    if (!q) {
        return NULL;
    }
    q->head = NULL;
    q->tail = NULL;
    q->size = 0;
    return q;
}

/* Free all storage used by queue */
void q_free(queue_t *q)
{
    /* TODO: How about freeing the list elements and the strings? */
    list_ele_t *ptr;
    if (!q)
        return;
    while (q->head) {
        ptr = q->head;
        q->head = ptr->next;
        free(ptr->value);
        free(ptr);
    }
    /* Free queue structure */
    free(q);
}

/*
 * Attempt to insert element at head of queue.
 * Return true if successful.
 * Return false if q is NULL or could not allocate space.
 * Argument s points to the string to be stored.
 * The function must explicitly allocate space and copy the string into it.
 */
bool q_insert_head(queue_t *q, char *s)
{
    list_ele_t *newh;
    if (!q) {
        return false;
    }
    /* TODO: What should you do if the q is NULL? */
    newh = malloc(sizeof(list_ele_t));
    if (!newh) {
        return false;
    }
    newh->value = (char *) malloc((strlen(s) + 1) * sizeof(char));
    if (!newh->value) {
        free(newh);
        return false;
    }
    memcpy(newh->value, s, strlen(s) + 1);
    /* Don't forget to allocate space for the string and copy it */
    /* What if either call to malloc returns NULL? */
    newh->next = q->head;
    q->head = newh;
    if (q->size == 0) {
        q->tail = newh;
    }
    q->size = q->size + 1;
    return true;
}

/*
 * Attempt to insert element at tail of queue.
 * Return true if successful.
 * Return false if q is NULL or could not allocate space.
 * Argument s points to the string to be stored.
 * The function must explicitly allocate space and copy the string into it.
 */
bool q_insert_tail(queue_t *q, char *s)
{
    list_ele_t *newt;
    if (!q) {
        return false;
    }
    newt = malloc(sizeof(list_ele_t));
    if (!newt) {
        return false;
    }
    newt->value = (char *) malloc((strlen(s) + 1) * sizeof(char));
    if (!newt->value) {
        free(newt);
        return false;
    }
    memcpy(newt->value, s, strlen(s) + 1);
    newt->next = NULL;
    if (q->size == 0) {
        q->head = newt;
    } else {
        q->tail->next = newt;
    }
    q->tail = newt;
    q->size = q->size + 1;
    return true;
}

/*
 * Attempt to remove element from head of queue.
 * Return true if successful.
 * Return false if queue is NULL or empty.
 * If sp is non-NULL and an element is removed, copy the removed string to *sp
 * (up to a maximum of bufsize-1 characters, plus a null terminator.)
 * The space used by the list element and the string should be freed.
 */
bool q_remove_head(queue_t *q, char *sp, size_t bufsize)
{
    list_ele_t *ptr;
    if (q == NULL || q->size == 0 || !q->head || !q->head->value) {
        return false;
    }
    ptr = q->head;
    if (sp && ptr->value) {
        if (strlen(ptr->value) <= bufsize) {
            memcpy(sp, ptr->value, strlen(ptr->value));
            sp[strlen(ptr->value)] = '\0';
        } else {
            memcpy(sp, ptr->value, bufsize - 1);
            sp[bufsize - 1] = '\0';
        }
    }
    q->head = q->head->next;
    free(ptr->value);
    free(ptr);
    q->size = q->size - 1;
    return true;
}

/*
 * Return number of elements in queue.
 * Return 0 if q is NULL or empty
 */
int q_size(queue_t *q)
{
    return q != NULL ? q->size : 0;
}

/*
 * Reverse elements in queue
 * No effect if q is NULL or empty
 * This function should not allocate or free any list elements
 * (e.g., by calling q_insert_head, q_insert_tail, or q_remove_head).
 * It should rearrange the existing ones.
 */
void q_reverse(queue_t *q)
{
    if (!q || q->size <= 1) {
        return;
    }
    list_ele_t *ptr, *pre = NULL, *nxt;
    q->tail = q->head;
    ptr = q->head;
    while (ptr->next) {
        nxt = ptr->next;
        ptr->next = pre;
        pre = ptr;
        ptr = nxt;
    }
    ptr->next = pre;
    q->head = ptr;
}

/*
 * Sort elements of queue in ascending order
 * No effect if q is NULL or empty. In addition, if q has only one
 * element, do nothing.
 */
void q_sort(queue_t *q)
{
    if (!q || q->size <= 1) {
        return;
    }
    q->head = merge_sort(q->head);
    list_ele_t *t = q->head;
    while (!t->next) {
        t = t->next;
    }
    q->tail = t;
}

list_ele_t *merge_sort(list_ele_t *start)
{
    if (!start || !start->next)
        return start;
    list_ele_t *left = start;
    list_ele_t *right = start->next;
    list_ele_t *head, *now;

    while (right && right->next) {
        left = left->next;
        right = right->next->next;
    }
    right = left->next;
    left->next = NULL;
    left = merge_sort(start);
    right = merge_sort(right);
    if (strnatcmp(left->value, right->value) < 0) {
        head = left;
        left = left->next;
    } else {
        head = right;
        right = right->next;
    }
    now = head;
    while (left && right) {
        if (strnatcmp(left->value, right->value) < 0) {
            now->next = left;
            left = left->next;
        } else {
            now->next = right;
            right = right->next;
        }
        now = now->next;
    }
    if (!left) {
        now->next = right;
    }
    if (!right) {
        now->next = left;
    }

    return head;
}