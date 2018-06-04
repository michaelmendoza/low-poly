using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DisplayUI : MonoBehaviour {

    public GameObject Tooltip;

    public void Update()
    {
        
    }

    private void OnMouseEnter()
    {
        Tooltip.SetActive(true);
        //Tooltip.transform.LookAt(Camera.main.transform.position);
    }

    public void OnMouseExit()
    {
        Tooltip.SetActive(false);
    }
}
