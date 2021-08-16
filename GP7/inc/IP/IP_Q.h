/*********************************************************************
*  
*   IAR PowerPac - TCP/IP Stack
*
*   (c) Copyright IAR Systems 2008.  All rights reserved.
*
**********************************************************************
----------------------------------------------------------------------
File    : IP_Q.h
Purpose : Include file for Queues.
--------  END-OF-HEADER  ---------------------------------------------
*/

/* Additional Copyrights: */
/* Copyright  2000 By InterNiche Technologies Inc. All rights reserved */
/* Portions Copyright 1990-1994 by NetPort 10/13/90
 * Portions Copyright 1986 by Carnegie Mellon
 * Portions Copyright 1983 by the Massachusetts Institute of
 * Technology
 */

#ifndef _Q_H_
#define  _Q_H_ 1

typedef struct q_elt {     /* queue element: cast to right type */
   struct   q_elt   *   qe_next; /* it's just a pointer to next elt */
} QUEUE_ITEM;

typedef struct   queue {        /* queue header */
   QUEUE_ITEM * q_head;        /* first element in queue */
   QUEUE_ITEM * q_tail;        /* last element in queue */
   int          q_len;         /* number of elements in queue */
   int          q_max;         /* maximum length */
   int          q_min;         /* minimum length */
} QUEUE;

void     IP_Q_Add              (QUEUE*, void*);    // Add item
void *   IP_Q_GetRemoveFirst   (QUEUE*);           // Get and remove first item
void *   IP_Q_GetFirst         (QUEUE*);           // Get first item. Does NOT remove it from queue.
void     IP_Q_RemoveItem       (QUEUE * q, void * elt);
void *   IP_Q_TryGetRemoveFirst(QUEUE * q);

#endif   /* _Q_H_ */


